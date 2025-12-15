#!/usr/bin/env python3

import os
import re
import subprocess
import sys
from pathlib import Path

def find_markdown_files(content_dir):
    """Find all markdown files in content directory."""
    return list(Path(content_dir).rglob('*.md'))

def extract_mermaid_blocks(content):
    """Extract mermaid blocks with filename attribute."""
    # Pattern: ```mermaid {filename="diagram.svg"}
    pattern = r'```mermaid\s+\{[^}]*filename=["\']([^"\']+)["\'][^}]*\}\s*\n(.*?)```'
    matches = re.finditer(pattern, content, re.DOTALL)

    blocks = []
    for match in matches:
        filename = match.group(1)
        code = match.group(2).strip()

        # Strip blockquote prefixes ("> ") from each line if present
        # This handles mermaid blocks inside markdown blockquotes
        lines = code.split('\n')
        cleaned_lines = []
        for line in lines:
            # Remove leading "> " or ">" from blockquoted content
            if line.startswith('> '):
                cleaned_lines.append(line[2:])
            elif line.startswith('>'):
                cleaned_lines.append(line[1:])
            else:
                cleaned_lines.append(line)

        code = '\n'.join(cleaned_lines)

        blocks.append({
            'filename': filename,
            'code': code
        })

    return blocks

def render_mermaid(code, output_path, config_path, puppeteer_config):
    """Render mermaid code to SVG using mmdc."""
    # Create temp file for mermaid code
    temp_mmd = output_path.with_suffix('.mmd.tmp')

    try:
        # Write mermaid code to temp file
        temp_mmd.write_text(code)

        # Run mmdc with both config files and transparent background
        cmd = [
            'mmdc',
            '-i', str(temp_mmd),
            '-o', str(output_path),
            '-c', config_path,
            '-p', puppeteer_config,
            '-b', 'transparent'
        ]

        result = subprocess.run(cmd, capture_output=True, text=True)

        if result.returncode != 0:
            print(f"  ✗ Error rendering {output_path.name}:", file=sys.stderr)
            print(f"    {result.stderr}", file=sys.stderr)
            return False

        print(f"  ✓ Rendered {output_path.name}")
        return True

    finally:
        # Clean up temp file
        if temp_mmd.exists():
            temp_mmd.unlink()

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

            if render_mermaid(block['code'], output_path, config_path, puppeteer_config):
                total_rendered += 1

    print(f"\n✓ Processed {total_blocks} mermaid block(s), rendered {total_rendered} successfully")

    if total_rendered < total_blocks:
        sys.exit(1)

def main():
    # Paths - can be overridden by environment variables
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
