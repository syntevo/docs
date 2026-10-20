# frozen_string_literal: true

require "set"

# Keep the existing preference for Latest when the page or one of its aliases
# still resolves. Older manuals often have a different structure, so absent
# Latest counterparts must not be advertised as canonical URLs.
Jekyll::Hooks.register :site, :pre_render do |site|
  available_urls = site.pages.map(&:url).to_set
  redirect_file = [File.join(site.source, "_redirects"), File.expand_path("../_redirects", site.source)]
                  .find { |path| File.file?(path) }
  redirects = {}
  if redirect_file
    File.foreach(redirect_file) do |line|
      source, target, = line.split
      redirects[source] = target if source&.start_with?("/") && target&.start_with?("/")
    end
  end

  resolves = lambda do |path|
    [path, path.sub(/\.html\z/, "")].any? do |initial|
      current = initial
      visited = Set.new
      while redirects.key?(current) && !visited.include?(current)
        visited.add(current)
        current = redirects[current]
      end
      !visited.include?(current) &&
        [current, "#{current}.html", "#{current}/"].any? { |url| available_urls.include?(url) }
    end
  end

  site.pages.each do |page|
    canonical = page.url
    match = canonical.match(%r{\A/([^/]+)/[^/]+(/.*)\z})
    if match
      latest = "/#{match[1]}/Latest#{match[2]}"
      canonical = latest if resolves.call(latest)
    end

    page.data["canonical_path"] = canonical.sub(/\.html\z/, "")
  end
end
