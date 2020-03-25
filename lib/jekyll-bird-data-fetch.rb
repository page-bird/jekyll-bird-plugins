require_relative "jekyll-bird-data-fetch/version"
require_relative "jekyll-bird-data-fetch/importer"
require_relative "jekyll-bird-data-fetch/generator"
require_relative "jekyll-bird-data-fetch/file_creator"
require_relative "jekyll-bird-data-fetch/blog_generator"

module JekyllBirdDataFetch
  class Error < StandardError; end
end
