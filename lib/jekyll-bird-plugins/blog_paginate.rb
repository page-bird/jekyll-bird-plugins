module Jekyll
  class BlogPaginate
    attr_accessor :site, :dir, :posts_per_page

    def initialize(site, dir, posts_per_page: 8)
      @site = site
      @dir = dir
      @posts_per_page = posts_per_page

      build_pagination_pages
    end

    private

      def no_of_pages
        @_no_of_pages ||= Pager.calculate_pages(post_pages, posts_per_page)
      end

      def build_pagination_pages
        (1..no_of_pages).each do |num_page|
          pager = Pager.new(site, num_page, post_pages, no_of_pages, posts_per_page)
          if num_page > 1
            create_new_page(num_page, pager)
          else
            index_page.pager = pager
          end
        end
      end

      def create_new_page num_page, pager
        newpage = BlogIndexPage.new(site, site.source, dir)
        newpage.pager = pager
        newpage.dir = Pager.paginate_path(site, num_page)
        site.pages << newpage
      end

      def index_page
        @_index_page ||= site.pages.detect { |p| p.class.name == "Jekyll::BlogIndexPage" }
      end

      def post_pages
        @_post_pages ||= site.pages.select { |p| p.class.name == "Jekyll::BlogPostPage" }
      end
  end
end
