module Jekyll
  class Paginate
    attr_accessor :site, :dir, :index_page, :post_pages, :posts_per_page, :record

    def initialize(site, dir, index_page:, post_pages:, **options)
      @site = site
      @dir = dir
      @index_page = index_page
      @post_pages = post_pages
      @posts_per_page = options[:posts_per_page] || 8
      @record = options[:record]

      build_pagination_pages
    end

    private

      def no_of_pages
        @_no_of_pages ||= Pager.calculate_pages(post_pages, posts_per_page)
      end

      def build_pagination_pages
        (1..no_of_pages).each do |num_page|
          pager = Pager.new(site, num_page, post_pages, no_of_pages, posts_per_page, dir)
          if num_page > 1
            create_new_page(num_page, pager)
          else
            index_page.pager = pager
          end
        end
      end

      def create_new_page num_page, pager
        newpage = index_page.class.new(site, site.source, dir, record: record)
        newpage.pager = pager
        newpage.dir = Pager.paginate_path(site, num_page, dir)
        site.pages << newpage
      end
  end
end
