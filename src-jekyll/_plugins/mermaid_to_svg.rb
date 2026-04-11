# Converts Mermaid code blocks with filename attribute to img tags pointing to pre-rendered SVGs.
# The original Mermaid source is kept in a collapsed details block so the published HTML
# stays machine-readable for search/indexing/tools without making the docs visually noisy.
# Example input:
# ```mermaid {filename="diagram.svg"}
# graph TD
#   A --> B
# ```
#
# Output:
# <img src="diagram.svg" alt="Mermaid diagram" />
#
require 'cgi'
require 'jekyll'

module Syntevo
  module MermaidToSvg
    # Pattern to match mermaid code blocks with attribute lists.
    # Note: This runs after gfm_admonitions.rb which strips ">" prefixes from blockquotes,
    # so we don't need to handle blockquote prefixes here.
    MERMAID_BLOCK_REGEX = /```mermaid\s+\{(?<attrs>[^}]*)\}[^\n]*\n(?<code>.*?)\n```/m.freeze
    ATTRIBUTE_REGEX = /([A-Za-z_][A-Za-z0-9_-]*)\s*=\s*(["'])(.*?)\2/.freeze
    DEFAULT_ALT = 'Mermaid diagram'.freeze
    DEFAULT_SOURCE_TITLE = 'Mermaid source'.freeze
    SOURCE_GROUP_REGEX = /(?<group>(?:<details class="mermaid-source">.*?<\/details>\s*){2,})/m.freeze

    def self.parse_attributes(raw_attrs)
      raw_attrs.scan(ATTRIBUTE_REGEX).each_with_object({}) do |(key, _quote, value), attrs|
        attrs[key.downcase] = value
      end
    end

    def self.truthy?(value)
      return false if value.nil?

      %w[1 true yes on].include?(value.strip.downcase)
    end

    def self.falsey?(value)
      return false if value.nil?

      %w[0 false no off].include?(value.strip.downcase)
    end

    def self.source_enabled?(attrs)
      return false if truthy?(attrs['hidesource'])

      source = attrs['showsource'] || attrs['source']
      return true if source.nil?

      !falsey?(source)
    end

    def self.source_title(attrs)
      attrs['source_title'] || attrs['source-title'] || attrs['sourcetitle'] || DEFAULT_SOURCE_TITLE
    end

    def self.source_markup(code, title)
      escaped_code = CGI.escapeHTML(code.rstrip)
      escaped_title = CGI.escapeHTML(title)

      <<~HTML.chomp
        <details class="mermaid-source">
          <summary>#{escaped_title}</summary>
          <pre><code class="language-mermaid">#{escaped_code}</code></pre>
        </details>
      HTML
    end

    def self.transform(content)
      transformed = content.gsub(MERMAID_BLOCK_REGEX) do |match|
        attrs = parse_attributes(Regexp.last_match[:attrs])
        filename = attrs['filename']

        next match if filename.nil? || filename.empty?

        alt = attrs.fetch('alt', DEFAULT_ALT)
        source = source_enabled?(attrs) ? source_markup(Regexp.last_match[:code], source_title(attrs)) : ''

        next source if truthy?(attrs['hidden'])

        <<~HTML.chomp
          <div class="mermaid-figure">
            <img src="#{CGI.escapeHTML(filename)}" alt="#{CGI.escapeHTML(alt)}" class="mermaid-diagram" />
            #{source}
          </div>
        HTML
      end

      transformed.gsub(SOURCE_GROUP_REGEX) do
        group = Regexp.last_match[:group].rstrip
        <<~HTML.chomp
          <div class="mermaid-source-group">
            #{group}
          </div>
        HTML
      end
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc|
  content = doc.content
  next if content.nil? || content.empty?

  doc.content = Syntevo::MermaidToSvg.transform(content)
end
