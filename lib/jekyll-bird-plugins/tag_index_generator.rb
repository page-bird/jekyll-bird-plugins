module Jekyll
  class TagIndexGenerator < Generator
    safe true

    def generate(site)
      if records = site.data["bird"]["blog"] && site.data["bird"]["blog"]["active"] && site.data["bird"]["blog"]["tags"]
        warn "Bird starting TagIndexGenerator...".cyan

        records.each do |record|
          dir = "blog/tags/" + record['name']
          tag_index_page = TagIndexPage.new(site, site.source, dir, record: record, original: true)
          site.pages << tag_index_page
          Paginate.new(site, dir, index_page: tag_index_page, post_pages: post_pages_for_tag_name(site, record['name']), record: record)
        end
      end
    end

    def post_pages_for_tag_name(site, tag_name)
      site.pages.select { |p| p.class.name == "Jekyll::BlogPostPage" && p["tags"] && p["tags"].map { |h| h['name'] }.include?(tag_name) }
    end
  end

  class TagIndexPage < Page
    def initialize(site, base, dir, record:, **options)
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

      if options[:original]
        warn "  Bird generated a TagIndex for #{ record['name'] }".cyan
      end
    end
  end
end
