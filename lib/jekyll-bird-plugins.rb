require_relative "jekyll-bird-plugins/version"
require_relative "jekyll-bird-plugins/importer"
require_relative "jekyll-bird-plugins/generator"
require_relative "jekyll-bird-plugins/file_creator"
require_relative "jekyll-bird-plugins/blog_generator"
require_relative "jekyll-bird-plugins/tag_index_generator"
require_relative "jekyll-bird-plugins/pager"
require_relative "jekyll-bird-plugins/paginate"
require_relative "jekyll-bird-plugins/base64_filter"

module JekyllBirdPlugins
  class Error < StandardError; end
end
