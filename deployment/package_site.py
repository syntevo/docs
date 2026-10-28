#!/usr/bin/env python3
"""Create the Cloudflare Pages artifact for one documentation hostname."""

import argparse
import re
import shutil
import xml.etree.ElementTree as ET
from pathlib import Path
from urllib.parse import unquote, urljoin, urlsplit


REPO = Path(__file__).resolve().parents[1]
SMARTGIT_HOST = "docs.smartgit.dev"
SYNTEVO_HOST = "docs.syntevo.com"
OTHER_PRODUCTS = ("/DeepGit/", "/SmartSVN/", "/SmartSynchronize/")
LINK_ATTRIBUTE = re.compile(
    r'''(?P<start>\b(?:href|src)=)(?P<quote>["'])(?P<url>.*?)(?P=quote)''',
    re.IGNORECASE,
)
CANONICAL_LINK = re.compile(r'(<link\s+rel="canonical"\s+href=")([^"]+)(")')


def is_smartgit(path):
    return path == "/SmartGit" or path.startswith("/SmartGit/")


def without_smartgit_prefix(path):
    return (path[len("/SmartGit"):] or "/") if is_smartgit(path) else path


def replace_link(match, url):
    return f'{match.group("start")}{match.group("quote")}{url}{match.group("quote")}'


def final_page_path(output, path):
    relative = unquote(path).lstrip("/")
    if (output / relative / "index.html").is_file():
        return path if path.endswith("/") else path + "/"
    if (output / relative).is_file():
        if path.endswith("/index.html"):
            return path[:-len("index.html")]
        if path.endswith(".html"):
            return path[:-5]
    return path


def read_redirects(path):
    rules = []
    for number, line in enumerate(path.read_text().splitlines(), 1):
        if not line.strip() or line.startswith("#"):
            continue
        fields = line.split()
        if len(fields) != 3 or not fields[0].startswith("/") or not fields[1].startswith("/"):
            raise ValueError(f"Invalid redirect at {path}:{number}: {line}")
        rules.append(fields)
    return rules


def flatten_redirects(rules):
    targets = {source: target for source, target, _ in rules}
    flattened = []
    for source, target, status in rules:
        visited = {source}
        while target in targets:
            if target in visited:
                raise ValueError(f"Redirect cycle involving {source} and {target}")
            visited.add(target)
            target = targets[target]
        flattened.append((source, target, status))
    return flattened


def write_redirects(output, variant):
    rules = read_redirects(REPO / "_redirects")
    if variant == "smartgit":
        rules = [rule for rule in rules if is_smartgit(rule[0])]
        if any(not is_smartgit(rule[1]) for rule in rules):
            raise ValueError("SmartGit redirect leaves /SmartGit")
        legacy = flatten_redirects(rules)
        native = [
            (without_smartgit_prefix(source),
             final_page_path(output, without_smartgit_prefix(target)), status)
            for source, target, status in legacy
        ]
        native = flatten_redirects([rule for rule in native if rule[0] != rule[1]])
        targets = {source: target for source, target, _ in native}
        # Keep prefixed and root aliases in one hop, plus prefixed chapter and asset URLs.
        prefixed = [
            (source, targets.get(without_smartgit_prefix(source),
                                 final_page_path(output, without_smartgit_prefix(target))), status)
            for source, target, status in legacy
        ]
        rules = native + prefixed + [
            ("/index.html", "/", "301"),
            ("/SmartGit", "/", "301"),
            ("/SmartGit/index.html", "/", "301"),
            ("/SmartGit/*", "/:splat", "301"),
        ]
    else:
        rules = [
            (source, target + "/" if not target.endswith("/") and
             (output / target.lstrip("/") / "index.html").is_file() else target, status)
            for source, target, status in rules if not is_smartgit(source)
        ]
    (output / "_redirects").write_text(
        "".join(" ".join(rule) + "\n" for rule in rules)
    )
    return rules


def clean_jekyll_output(output):
    for file in output.rglob("*.html"):
        html = file.read_text(encoding="utf-8", errors="replace")
        if 'http-equiv="refresh"' in html and "<body" not in html:
            file.unlink()
    for file in output.rglob("*.md"):
        file.unlink()


def externalize_other_product_links(output):
    count = 0
    for file in (output / "SmartGit").rglob("*.html"):
        page_url = f"https://{SMARTGIT_HOST}/{file.relative_to(output).as_posix()}"
        html = file.read_text(encoding="utf-8")

        def replace(match):
            nonlocal count
            absolute = urljoin(page_url, match.group("url"))
            parsed = urlsplit(absolute)
            if parsed.netloc != SMARTGIT_HOST or not parsed.path.startswith(OTHER_PRODUCTS):
                return match.group(0)
            count += 1
            return replace_link(match, parsed._replace(netloc=SYNTEVO_HOST).geturl())

        changed = LINK_ATTRIBUTE.sub(replace, html)
        if changed != html:
            file.write_text(changed, encoding="utf-8")
    return count


def move_smartgit_to_root(output):
    product = output / "SmartGit"
    for entry in product.iterdir():
        target = output / entry.name
        if target.exists():
            raise ValueError(f"SmartGit root collides with shared output: {target}")
        shutil.move(str(entry), target)
    product.rmdir()


def rewrite_smartgit_urls(output, rules):
    targets = {source: target for source, target, _ in rules if "*" not in source}
    for file in output.rglob("*.html"):
        html = file.read_text(encoding="utf-8")

        def relocate_link(match):
            parsed = urlsplit(match.group("url"))
            if parsed.netloc not in ("", SMARTGIT_HOST) or not is_smartgit(parsed.path):
                return match.group(0)
            return replace_link(match, parsed._replace(
                path=without_smartgit_prefix(parsed.path)
            ).geturl())

        def canonical_target(match):
            parsed = urlsplit(match.group(2))
            path = parsed.path
            visited = set()
            while path in targets:
                if path in visited:
                    raise ValueError(f"Canonical redirect cycle: {path}")
                visited.add(path)
                path = targets[path]
            canonical = parsed._replace(path=final_page_path(output, path)).geturl()
            return f"{match.group(1)}{canonical}{match.group(3)}"

        changed = CANONICAL_LINK.sub(canonical_target, LINK_ATTRIBUTE.sub(relocate_link, html))
        if changed != html:
            file.write_text(changed, encoding="utf-8")


def normalize_sitemap(output, host, root_product=False):
    sitemap = output / "sitemap.xml"
    ET.register_namespace("", "http://www.sitemaps.org/schemas/sitemap/0.9")
    ET.register_namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")
    tree = ET.parse(sitemap)
    count = 0
    for loc in tree.iter("{http://www.sitemaps.org/schemas/sitemap/0.9}loc"):
        url = urlsplit(loc.text or "")
        if url.netloc != host:
            raise ValueError(f"Unexpected sitemap host: {loc.text}")
        path = url.path[:-5] if url.path.endswith(".html") else url.path
        if root_product:
            path = without_smartgit_prefix(path)
        loc.text = url._replace(path=path).geturl()
        count += 1
    tree.write(sitemap, encoding="utf-8", xml_declaration=True)
    return count


def package(source, output, variant):
    if output.exists():
        shutil.rmtree(output)
    shutil.copytree(source, output)
    clean_jekyll_output(output)
    for file in output.glob("*.bat"):
        file.unlink()
    cross_product_links = externalize_other_product_links(output) if variant == "smartgit" else 0
    if variant == "smartgit":
        move_smartgit_to_root(output)
    rules = write_redirects(output, variant)
    shutil.copy2(REPO / "favicon.ico", output / "favicon.ico")
    if variant == "smartgit":
        rewrite_smartgit_urls(output, rules)
        shutil.copy2(REPO / "deployment/smartgit-404.html", output / "404.html")
        shutil.copy2(REPO / "deployment/smartgit-robots.txt", output / "robots.txt")
        entries = normalize_sitemap(output, SMARTGIT_HOST, root_product=True)
    else:
        shutil.copy2(REPO / "404.html", output / "404.html")
        shutil.copy2(REPO / "robots.txt", output / "robots.txt")
        entries = normalize_sitemap(output, SYNTEVO_HOST)
    print(f"{variant}: {len(rules)} redirects, {entries} sitemap entries, "
          f"{cross_product_links} cross-product links -> {output}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("variant", choices=("smartgit", "syntevo"))
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    package(args.source, args.output, args.variant)


if __name__ == "__main__":
    main()
