module Jekyll
  class BlogGenerator < Generator
    safe true

    def generate(site)
      if records = site.data["bird"]["blog"] && site.data["bird"]["blog"]["active"] && site.data["bird"]["blog"]["published_posts"]
        warn "✏️ Bird started BlogGenerator...".green
        dir = "blog"

        site.pages << BlogIndexPage.new(site, site.source, dir)

        records.each do |record|
          site.pages << BlogPostPage.new(site, site.source, dir, record)
        end
      end
    end
  end

  class BlogIndexPage < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"
      @path = if File.exist?(site.in_source_dir("_layouts", "blog_index.html"))
                site.in_source_dir("_layouts", "blog_index.html")
              else
                site.in_theme_dir("_layouts", "blog_index.html")
              end

      process(@name)
      read_yaml(@path, "")
      data["title"] = "Blog"

      warn "✏️ Bird generated a BlogIndex".green
    end
  end

  class BlogPostPage < Page
    def initialize(site, base, dir, record)
      @site = site
      @base = base
      @dir = dir
      @name = record["slug"] + ".html"
      @path = if File.exist?(site.in_source_dir("_layouts", "blog_post.html"))
                site.in_source_dir("_layouts", "blog_post.html")
              else
                site.in_theme_dir("_layouts", "blog_post.html")
              end

      process(@name)
      read_yaml(@path, "")
      data["title"] = record["slug"]
      data["resource"] = record

      warn "✏️ Bird generated a BlogPost: #{ self.data['title'] }".green
    end
  end
end
