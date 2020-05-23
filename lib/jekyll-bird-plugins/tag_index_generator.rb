module Jekyll
  class TagIndexGenerator < Generator
    safe true

    def generate(site)
      if records = site.data["bird"]["blog"] && site.data["bird"]["blog"]["active"] && site.data["bird"]["blog"]["tags"]
        warn "Bird starting TagIndexGenerator...".cyan

        records.each do |record|
          dir = "blog/tags/" + record['name']
          site.pages << TagIndexPage.new(site, site.source, dir, record, original: true)
        end

        # BlogPaginate.new(site, dir)
      end
    end
  end

  class TagIndexPage < Page
    def initialize(site, base, dir, record, original: false)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"
      @path = if File.exist?(site.in_source_dir("_layouts", "tag_index.html"))
                site.in_source_dir("_layouts", "tag_index.html")
              else
                site.in_theme_dir("_layouts", "tag_index.html")
              end

      process(@name)
      read_yaml(@path, "")
      site_name = site.data["bird"]["name"]
      data["title"] = record['name'].capitalize + " | Blog"
      data["resource"] = record

      if original
        warn "  Bird generated a TagIndex for #{ record['name'] }".cyan
      end
    end
  end
end
