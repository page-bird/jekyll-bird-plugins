module Jekyll
  class Pager
    attr_reader :page, :per_page, :posts, :total_posts, :total_pages,
      :previous_page, :previous_page_path, :next_page, :next_page_path

    def self.calculate_pages(post_pages, per_page)
      (post_pages.size.to_f / per_page.to_i).ceil
    end

    def self.paginate_path(site, num_page)
      return nil if num_page.nil?
      return "/blog/" if num_page <= 1
      return "/blog/pages/#{ num_page }"
    end

    def initialize(site, page, post_pages, total_pages, posts_per_page)
      @page = page
      @per_page = posts_per_page
      @total_pages = total_pages

      if @page > @total_pages
        raise RuntimeError, "page number can't be greater than total pages: #{@page} > #{@total_pages}"
      end

      init = (@page - 1) * @per_page
      offset = (init + @per_page - 1) >= post_pages.size ? post_pages.size : (init + @per_page - 1)

      @total_posts = post_pages.size
      @posts = post_pages[init..offset]
      @previous_page = @page != 1 ? @page - 1 : nil
      @previous_page_path = Pager.paginate_path(site, @previous_page)
      @next_page = @page != @total_pages ? @page + 1 : nil
      @next_page_path = Pager.paginate_path(site, @next_page)
    end

    def to_liquid
      {
        'page' => page,
        'per_page' => per_page,
        'posts' => posts,
        'total_posts' => total_posts,
        'total_pages' => total_pages,
        'previous_page' => previous_page,
        'previous_page_path' => previous_page_path,
        'next_page' => next_page,
        'next_page_path' => next_page_path
      }
    end

  end
end
