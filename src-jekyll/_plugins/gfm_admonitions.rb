# Converts GitHub-style admonitions in Markdown to HTML blocks during Jekyll build.
# Example input:
# > [!WARNING]
# > Be careful!
#
require 'jekyll'

module Syntevo
  module GfmAdmonitions
    TYPE_TITLES = {
      'note' => 'Note',
      'tip' => 'Tip',
      'warning' => 'Warning',
      'important' => 'Important',
      'caution' => 'Caution',
      'example' => 'Example'
    }.freeze

    ICON_SVGS = {
      'note' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <circle cx="8" cy="8" r="6.5" fill="none" stroke="currentColor" stroke-width="1.5"/>
  <rect x="7.25" y="6.8" width="1.5" height="5.2" rx="0.75" fill="currentColor"/>
  <circle cx="8" cy="4.5" r="1" fill="currentColor"/>
</svg>
      }.strip,
      'example' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <circle cx="8" cy="8" r="6.5" fill="none" stroke="currentColor" stroke-width="1.5"/>
  <rect x="7.25" y="6.8" width="1.5" height="5.2" rx="0.75" fill="currentColor"/>
  <circle cx="8" cy="4.5" r="1" fill="currentColor"/>
</svg>
      }.strip,
      'tip' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <circle cx="8" cy="6" r="4.25" fill="none" stroke="currentColor" stroke-width="1.5"/>
  <rect x="6" y="10" width="4" height="2" rx="1" fill="currentColor"/>
  <rect x="5.5" y="12.5" width="5" height="1" rx="0.5" fill="currentColor"/>
</svg>
      }.strip,
      'warning' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <path d="M8 2 L14 14 H2 Z" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/>
  <rect x="7.25" y="6" width="1.5" height="5" rx="0.75" fill="currentColor"/>
  <circle cx="8" cy="12.25" r="1" fill="currentColor"/>
</svg>
      }.strip,
      'important' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <circle cx="8" cy="8" r="6.5" fill="none" stroke="currentColor" stroke-width="1.5"/>
  <rect x="7.25" y="6.8" width="1.5" height="5.2" rx="0.75" fill="currentColor"/>
  <circle cx="8" cy="4.5" r="1" fill="currentColor"/>
</svg>
      }.strip,
      'caution' => %Q{
<svg class="markdown-alert-icon" width="16" height="16" viewBox="0 0 16 16" aria-hidden="true">
  <path d="M8 2 L14 14 H2 Z" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/>
  <rect x="7.25" y="6" width="1.5" height="5" rx="0.75" fill="currentColor"/>
  <circle cx="8" cy="12.25" r="1" fill="currentColor"/>
</svg>
      }.strip
    }.freeze

    HEADER_REGEX = /^>\s*\[!(?<type>\w+)\]\s*(?<title>.*)?$/i.freeze

    def self.transform(content)
      lines = content.lines
      out = []
      i = 0
      while i < lines.length
        line = lines[i]
        # Only consider blockquotes
        if line.start_with?('>')
          # Peek first non-empty blockquote line for admonition header
          j = i
          header_match = nil
          while j < lines.length && lines[j].start_with?('>')
            stripped = lines[j].sub(/^>\s?/, '')
            unless stripped.strip.empty?
              header_match = HEADER_REGEX.match(lines[j])
              break
            end
            j += 1
          end

          if header_match
            type = header_match[:type].downcase
            klass = TYPE_TITLES.key?(type) ? type : 'note'
            title = header_match[:title]&.strip
            title = TYPE_TITLES[klass] if title.nil? || title.empty?

            # Collect blockquote lines for this admonition
            block = []
            while i < lines.length && lines[i].start_with?('>')
              block << lines[i]
              i += 1
            end

            # Remove the header line from the block and keep the rest as markdown
            body_lines = []
            header_consumed = false
            block.each do |bl|
              if !header_consumed && HEADER_REGEX.match(bl)
                header_consumed = true
                next
              end
              # Strip a single leading '> ' or '>'
              body_lines << bl.sub(/^>\s?/, '')
            end

            # Ensure there is a trailing newline so kramdown parses inner markdown
            body = body_lines.join
            body << "\n" unless body.end_with?("\n")

            out << %Q{<div class="markdown-alert markdown-alert-#{klass}" markdown="1">\n}
            icon = ICON_SVGS[klass] || ICON_SVGS['note']
            out << %Q{<p class="markdown-alert-title">#{icon}#{title}</p>\n}
            # Separate the title from the content to ensure paragraph breaks
            out << "\n"
            out << body
            out << "</div>\n"
            next
          else
            # Not an admonition blockquote, flush as-is until blockquote ends
            while i < lines.length && lines[i].start_with?('>')
              out << lines[i]
              i += 1
            end
            next
          end
        end

        out << line
        i += 1
      end

      out.join
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc|
  content = doc.content
  next if content.nil? || content.empty?

  doc.content = Syntevo::GfmAdmonitions.transform(content)
end
