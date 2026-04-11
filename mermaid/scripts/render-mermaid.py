#!/usr/bin/env python3

import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import xml.etree.ElementTree as ET
from pathlib import Path

MERMAID_BLOCK_REGEX = re.compile(
    r'```mermaid\s+\{(?P<attrs>[^}]*)\}[^\n]*\n(?P<code>.*?)```',
    re.DOTALL,
)
ATTRIBUTE_REGEX = re.compile(r'([A-Za-z_][A-Za-z0-9_-]*)\s*=\s*(["\'])(.*?)\2')
THEME_CSS_REGEX = re.compile(r'(?P<prefix>["\']themeCSS["\']\s*:\s*)(?P<quote>["\'])(?P<css>.*?)(?P=quote)')
GITGRAPH_REGEX = re.compile(r'^\s*gitGraph(?:\s+\w+)?\s*:', re.MULTILINE)
VERTICAL_GITGRAPH_REGEX = re.compile(r'^\s*gitGraph\s+(BT|TB)\s*:', re.MULTILINE)
BRANCH_LABEL_HIDE_CSS = '.branchLabel,.branchLabelBkg{display:none}'
GITGRAPH_LABEL_FONT_CSS = '.commit-label,.commit-label-bkg,.tag-label{font-size:12px}'
SVG_NS = {'svg': 'http://www.w3.org/2000/svg'}
TAG_GAP_X = 18.0
TAG_STACK_STEP_Y = 20.0
TAG_TEXT_PADDING_MIN = 3.0
TAG_TEXT_PADDING_MAX = 5.0
DEFAULT_TAG_CENTER_SHIFT_Y = 10.0
MAX_RENDER_ATTEMPTS = 3
RETRY_DELAY_SECONDS = 1.0
BROWSER_CANDIDATES = (
    'chromium',
    'chromium-browser',
    'google-chrome',
    'google-chrome-stable',
)


def parse_attributes(raw_attrs):
    attrs = {}
    for key, _quote, value in ATTRIBUTE_REGEX.findall(raw_attrs):
        attrs[key.lower()] = value
    return attrs


def truthy(value):
    if value is None:
        return False
    return value.strip().lower() in {'1', 'true', 'yes', 'on'}


def resolve_browser_path(configured_path=None):
    env_path = os.getenv('PUPPETEER_EXECUTABLE_PATH')
    if env_path:
        env_candidate = Path(env_path)
        if env_candidate.is_file() and os.access(env_candidate, os.X_OK):
            return str(env_candidate)

    if configured_path:
        configured_candidate = Path(configured_path)
        if configured_candidate.is_file() and os.access(configured_candidate, os.X_OK):
            return str(configured_candidate)

    for candidate in BROWSER_CANDIDATES:
        resolved = shutil.which(candidate)
        if resolved:
            return resolved

    return None


def prepare_puppeteer_config(config_path):
    with open(config_path, 'r', encoding='utf-8') as handle:
        config = json.load(handle)

    browser_path = resolve_browser_path(config.get('executablePath'))
    if browser_path:
        config['executablePath'] = browser_path
    else:
        config.pop('executablePath', None)

    temp_config = tempfile.NamedTemporaryFile(
        mode='w',
        suffix='.json',
        prefix='mermaid-puppeteer-',
        delete=False,
        encoding='utf-8',
    )
    try:
        json.dump(config, temp_config)
        temp_config.write('\n')
        return temp_config.name
    finally:
        temp_config.close()


def find_markdown_files(content_dir):
    """Find all markdown files in the content directory."""
    return list(Path(content_dir).rglob('*.md'))


def extract_mermaid_blocks(content):
    """Extract mermaid blocks, preserving block attributes for render options."""
    blocks = []
    for match in MERMAID_BLOCK_REGEX.finditer(content):
        attrs = parse_attributes(match.group('attrs'))
        filename = attrs.get('filename')
        if not filename:
            continue

        code = match.group('code').strip()
        lines = code.split('\n')
        cleaned_lines = []
        for line in lines:
            if line.startswith('> '):
                cleaned_lines.append(line[2:])
            elif line.startswith('>'):
                cleaned_lines.append(line[1:])
            else:
                cleaned_lines.append(line)

        blocks.append({
            'filename': filename,
            'code': '\n'.join(cleaned_lines),
            'attrs': attrs,
        })

    return blocks


def inject_theme_css_rule(code, css_rule):
    """Inject themeCSS into the first Mermaid init directive if one is present."""
    escaped_css = css_rule.replace('\\', '\\\\').replace('"', '\\"')
    lines = code.splitlines(keepends=True)

    for index, line in enumerate(lines):
        stripped = line.lstrip()
        if not stripped:
            continue

        if stripped.startswith('%%{init:'):
            if 'themeCSS' in line:
                def replace_theme_css(match):
                    combined_css = f"{match.group('css')} {escaped_css}".strip()
                    return f"{match.group('prefix')}{match.group('quote')}{combined_css}{match.group('quote')}"

                lines[index] = THEME_CSS_REGEX.sub(replace_theme_css, line, count=1)
                return ''.join(lines)

            init_index = line.find('init:')
            object_start = line.find('{', init_index)
            if object_start != -1:
                lines[index] = (
                    f'{line[:object_start + 1]} "themeCSS": "{escaped_css}",'
                    f'{line[object_start + 1:]}'
                )
                return ''.join(lines)
            break

        break

    return f'%%{{init: {{"themeCSS": "{escaped_css}"}} }}%%\n{code}'


def format_number(value):
    number = f'{value:.6f}'.rstrip('0').rstrip('.')
    return number or '0'


def parse_svg_points(raw_points):
    values = [float(token) for token in re.split(r'[ ,\n\t]+', raw_points.strip()) if token]
    return list(zip(values[0::2], values[1::2]))


def element_class(element):
    return element.get('class', '')


def uses_vertical_gitgraph(code):
    return bool(VERTICAL_GITGRAPH_REGEX.search(code))


def uses_gitgraph(code):
    return bool(GITGRAPH_REGEX.search(code))


def realign_gitgraph_tags_left(svg_path):
    """Make BT/TB gitGraph tags horizontal and align them to the left of the graph."""
    ET.register_namespace('', SVG_NS['svg'])
    tree = ET.parse(svg_path)
    root = tree.getroot()

    if root.get('aria-roledescription') != 'gitGraph':
        return

    branch_x = []
    for line in root.iterfind('.//svg:line', SVG_NS):
        if 'branch' in element_class(line).split():
            branch_x.extend([float(line.get('x1')), float(line.get('x2'))])

    commit_bullet_groups = [
        group for group in root.iterfind('.//svg:g', SVG_NS)
        if element_class(group) == 'commit-bullets' and len(list(group))
    ]
    commit_circles = []
    if commit_bullet_groups:
        commit_bullets = commit_bullet_groups[-1]
        for circle in commit_bullets.iterfind('./svg:circle', SVG_NS):
            commit_circles.append({
                'x': float(circle.get('cx', 0)),
                'y': float(circle.get('cy', 0)),
            })

    if not branch_x and commit_circles:
        branch_x = [commit['x'] for commit in commit_circles]

    if not branch_x:
        return

    commit_label_groups = [
        group for group in root.iterfind('.//svg:g', SVG_NS)
        if element_class(group) == 'commit-labels' and len(list(group))
    ]
    if not commit_label_groups:
        return

    commit_labels = commit_label_groups[-1]
    children = list(commit_labels)
    default_tag_tip_x = min(branch_x) - TAG_GAP_X
    tag_entries = []
    leftmost = None

    index = 0
    while index <= len(children) - 3:
        polygon, hole, text = children[index:index + 3]
        if (
            element_class(polygon) == 'tag-label-bkg'
            and element_class(hole) == 'tag-hole'
            and element_class(text) == 'tag-label'
        ):
            points = parse_svg_points(polygon.get('points', ''))
            if not points:
                index += 3
                continue

            xs = sorted({x for x, _y in points})
            ys = [y for _x, y in points]
            min_x = min(x for x, _y in points)
            max_x = max(x for x, _y in points)
            min_y = min(ys)
            max_y = max(ys)
            y_mid = (min_y + max_y) / 2
            best_commit_index = None
            best_commit_x = None
            best_commit_y = None
            if commit_circles:
                best_commit_index, best_commit = min(
                    enumerate(commit_circles),
                    key=lambda item: abs(item[1]['x'] - min_x) * 1000 + abs(item[1]['y'] - y_mid),
                )
                best_commit_x = best_commit['x']
                best_commit_y = best_commit['y']

            tag_entries.append({
                'polygon': polygon,
                'hole': hole,
                'text': text,
                'total_width': max_x - min_x,
                'tip_width': xs[1] - xs[0] if len(xs) >= 2 else 10,
                'half_height': (max_y - min_y) / 2,
                'tip_offset': max(
                    (abs(y - y_mid) for x, y in points if abs(x - min_x) < 1e-6),
                    default=2,
                ),
                'hole_offset': abs(float(hole.get('cx', min_x)) - min_x),
                'original_y_mid': y_mid,
                'commit_index': best_commit_index,
                'commit_x': best_commit_x,
                'commit_y': best_commit_y,
            })
            index += 3
            continue

        index += 1

    tags_by_commit = {}
    for entry in tag_entries:
        commit_index = entry['commit_index']
        if commit_index is None:
            entry['target_y_mid'] = entry['original_y_mid'] + DEFAULT_TAG_CENTER_SHIFT_Y
            continue

        tags_by_commit.setdefault(commit_index, []).append(entry)

    for entries in tags_by_commit.values():
        entries.sort(key=lambda entry: entry['original_y_mid'])
        commit_y = entries[0]['commit_y']
        for tag_rank, entry in enumerate(entries):
            entry['target_y_mid'] = commit_y + TAG_STACK_STEP_Y * tag_rank

    for entry in tag_entries:
        polygon = entry['polygon']
        hole = entry['hole']
        text = entry['text']
        total_width = entry['total_width']
        tip_width = entry['tip_width']
        half_height = entry['half_height']
        tip_offset = entry['tip_offset']
        hole_offset = entry['hole_offset']
        y_mid = entry['target_y_mid']

        x_tip = (entry['commit_x'] - TAG_GAP_X) if entry['commit_x'] is not None else default_tag_tip_x
        x_body = x_tip - tip_width
        x_left = x_tip - total_width
        text_padding = max(
            TAG_TEXT_PADDING_MIN,
            min(TAG_TEXT_PADDING_MAX, (total_width - tip_width) / 8),
        )

        new_points = [
            (x_tip, y_mid + tip_offset),
            (x_tip, y_mid - tip_offset),
            (x_body, y_mid - half_height),
            (x_left, y_mid - half_height),
            (x_left, y_mid + half_height),
            (x_body, y_mid + half_height),
        ]

        polygon.set('points', ' '.join(
            f'{format_number(x)},{format_number(y)}' for x, y in new_points
        ))
        polygon.attrib.pop('transform', None)

        hole.set('cx', format_number(x_tip - hole_offset))
        hole.set('cy', format_number(y_mid))
        hole.attrib.pop('transform', None)

        text.set('x', format_number(x_left + text_padding))
        text.set('y', format_number(y_mid))
        text.set('text-anchor', 'start')
        text.set('dominant-baseline', 'middle')
        text.attrib.pop('transform', None)

        leftmost = x_left if leftmost is None else min(leftmost, x_left)

    if leftmost is None:
        return

    view_box = root.get('viewBox')
    if view_box:
        min_x, min_y, width, height = [float(value) for value in view_box.split()]
        if leftmost < min_x:
            delta = min_x - leftmost
            root.set(
                'viewBox',
                ' '.join(format_number(value) for value in (leftmost, min_y, width + delta, height)),
            )
            try:
                root.set('width', format_number(float(root.get('width', width)) + delta))
            except ValueError:
                pass

    tree.write(svg_path, encoding='unicode')


def render_mermaid(code, output_path, config_path, puppeteer_config, attrs):
    """Render mermaid code to SVG using mmdc, then apply optional SVG rewrites."""
    temp_mmd = output_path.with_suffix('.mmd.tmp')
    temp_puppeteer_config = None
    render_code = code
    branchpointer_style = truthy(attrs.get('branchpointers'))
    theme_css_rules = []

    if uses_gitgraph(code):
        theme_css_rules.append(GITGRAPH_LABEL_FONT_CSS)

    if branchpointer_style or truthy(attrs.get('hidebranchlabels')):
        theme_css_rules.append(BRANCH_LABEL_HIDE_CSS)

    if theme_css_rules:
        render_code = inject_theme_css_rule(render_code, ' '.join(theme_css_rules))

    try:
        temp_mmd.write_text(render_code)
        temp_puppeteer_config = prepare_puppeteer_config(puppeteer_config)

        cmd = [
            'mmdc',
            '-i', str(temp_mmd),
            '-o', str(output_path),
            '-c', config_path,
            '-p', temp_puppeteer_config,
            '-b', 'transparent',
        ]

        result = None
        for attempt in range(1, MAX_RENDER_ATTEMPTS + 1):
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode == 0:
                break

            if attempt < MAX_RENDER_ATTEMPTS:
                print(
                    f"  ! Retrying {output_path.name} after Mermaid CLI launch failure "
                    f"(attempt {attempt}/{MAX_RENDER_ATTEMPTS})",
                    file=sys.stderr,
                )
                time.sleep(RETRY_DELAY_SECONDS)

        if result is None or result.returncode != 0:
            print(f"  ✗ Error rendering {output_path.name}:", file=sys.stderr)
            print(f"    {result.stderr if result else 'unknown error'}", file=sys.stderr)
            return False

        tag_layout = attrs.get('taglayout', '').strip().lower()
        if not tag_layout and branchpointer_style and uses_vertical_gitgraph(code):
            tag_layout = 'left'

        if tag_layout == 'left':
            realign_gitgraph_tags_left(output_path)

        print(f"  ✓ Rendered {output_path.name}")
        return True

    finally:
        if temp_mmd.exists():
            temp_mmd.unlink()
        if temp_puppeteer_config and os.path.exists(temp_puppeteer_config):
            os.unlink(temp_puppeteer_config)


def process_markdown_files(content_dir, config_path, puppeteer_config):
    """Process all markdown files and render mermaid diagrams."""
    markdown_files = find_markdown_files(content_dir)
    print(f"Found {len(markdown_files)} markdown files")

    total_blocks = 0
    total_rendered = 0

    for md_file in markdown_files:
        content = md_file.read_text()
        blocks = extract_mermaid_blocks(content)

        if not blocks:
            continue

        print(f"\nProcessing {md_file.relative_to(content_dir)}: {len(blocks)} mermaid block(s)")
        total_blocks += len(blocks)

        md_dir = md_file.parent

        for block in blocks:
            output_path = md_dir / block['filename']

            if render_mermaid(block['code'], output_path, config_path, puppeteer_config, block['attrs']):
                total_rendered += 1

    print(f"\n✓ Processed {total_blocks} mermaid block(s), rendered {total_rendered} successfully")

    if total_rendered < total_blocks:
        sys.exit(1)


def main():
    content_dir = Path(os.getenv('WORKSPACE_CONTENT', '/workspace/content'))
    config_path = os.getenv('WORKSPACE_CONFIG', '/workspace/mermaid.config.json')
    puppeteer_config = os.getenv('WORKSPACE_PUPPETEER_CONFIG', '/workspace/puppeteer-config.json')

    if not content_dir.exists():
        print(f"Error: Content directory not found: {content_dir}", file=sys.stderr)
        sys.exit(1)

    if not Path(config_path).exists():
        print(f"Error: Config file not found: {config_path}", file=sys.stderr)
        sys.exit(1)

    if not Path(puppeteer_config).exists():
        print(f"Error: Puppeteer config file not found: {puppeteer_config}", file=sys.stderr)
        sys.exit(1)

    process_markdown_files(content_dir, config_path, puppeteer_config)


if __name__ == '__main__':
    main()
