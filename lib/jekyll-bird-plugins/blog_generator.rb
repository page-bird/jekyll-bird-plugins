require "pry"

module Jekyll
  class BlogGenerator < Generator
    safe true

    def generate(site)
      if records = site.data["bird"]["blog"] && site.data["bird"]["blog"]["active"] && site.data["bird"]["blog"]["published_posts"]
        warn "Bird starting BlogGenerator...".cyan
        dir = "blog"

        records.each do |record|
          site.pages << BlogPostPage.new(site, site.source, dir, record)
        end

        site.pages << BlogIndexPage.new(site, site.source, dir, original: true)

        posts_per_page = 8
        index_page = site.pages.detect { |p| p.class.name == "Jekyll::BlogIndexPage" }
        post_pages = site.pages.select { |p| p.class.name == "Jekyll::BlogPostPage" }

        paginate(site, index_page: index_page, post_pages: post_pages, dir: dir, posts_per_page: posts_per_page)
      end
    end

    def paginate(site, index_page:, post_pages:, dir:, posts_per_page:)
      pages = Pager.calculate_pages(post_pages, posts_per_page)
      (1..pages).each do |num_page|
        pager = Pager.new(site, num_page, post_pages, pages, posts_per_page)
        if num_page > 1
          newpage = BlogIndexPage.new(site, site.source, dir)
          newpage.pager = pager
          newpage.dir = Pager.paginate_path(site, num_page)
          site.pages << newpage
        else
          index_page.pager = pager
        end
      end
    end
  end

  class BlogIndexPage < Page
    def initialize(site, base, dir, original: false)
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
      site_name = site.data["bird"]["name"]
      data["title"] = site_name + " | Blog"

      if original
        warn "  Bird generated a BlogIndex".cyan
      end
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
      data["title"] = record["title"]
      data["description"] = record["preview_content"]
      data["image_url"] = record["preview_img_url"]
      data["date"] = record["published_at"]
      data["resource"] = record

      warn "  Bird generated a BlogPost: #{ self.data['title'] }".cyan
    end
  end
end
