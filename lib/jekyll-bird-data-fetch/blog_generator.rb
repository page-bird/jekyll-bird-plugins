# coding: utf-8
# Generate pages from individual records in yml files
# (c) 2014-2016 Adolfo Villafiorita
# Distributed under the conditions of the MIT License

module Jekyll
  require "pry"

  class BlogGenerator < Generator
    safe true

    def generate(site)
      warn "✏️ Bird started BlogGenerator...".green
      if site.layouts.key? "pb_blog_post"
        dir = "blog"
        records = site.data["bird"]["blog"]["published_posts"]
        records.each do |record|
          site.pages << BlogPostPage.new(site, site.source, dir, record)
        end
      end
    end
  end

  class BlogPostPage < Page
    def initialize(site, base, dir, record)
      @site = site
      @base = base
      @dir = dir
      @name = record["slug"] + ".html"
      @path = if File.exist?(site.in_source_dir("_layouts", "pb_blog_post.html"))
                site.in_source_dir("_layouts", "pb_blog_post.html")
              else
                site.in_theme_dir("_layouts", "pb_blog_post.html")
              end

      process(@name)
      read_yaml(@path, "")
      data["title"] = record["slug"]
      data["resource"] = record

      warn "✏️ Bird generated a BlogPost: #{ self.data['title'] }".green
    end
  end
end
