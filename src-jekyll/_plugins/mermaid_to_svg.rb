# Converts Mermaid code blocks with filename attribute to img tags pointing to pre-rendered SVGs
# Example input:
# ```mermaid {filename="diagram.svg"}
# graph TD
#   A --> B
# ```
#
# Output:
# <img src="diagram.svg" alt="Mermaid diagram" />
#
require 'jekyll'

module Syntevo
  module MermaidToSvg
    # Pattern to match mermaid code blocks with filename attribute
    # Note: This runs after gfm_admonitions.rb which strips ">" prefixes from blockquotes,
    # so we don't need to handle blockquote prefixes here
    MERMAID_BLOCK_REGEX = /```mermaid\s+\{[^}]*filename=["']([^"']+)["'][^}]*\}[^\n]*\n(.*?)\n```/m

    def self.transform(content)
      # Replace all mermaid blocks with img tags
      content.gsub(MERMAID_BLOCK_REGEX) do |match|
        filename = $1

        # The SVG is in the same directory as the markdown file
        %Q{<img src="#{filename}" alt="Mermaid diagram" class="mermaid-diagram" />}
      end
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc|
  content = doc.content
  next if content.nil? || content.empty?

  doc.content = Syntevo::MermaidToSvg.transform(content)
end
