require_relative "jekyll-bird-plugins/version"
require_relative "jekyll-bird-plugins/importer"
require_relative "jekyll-bird-plugins/generator"
require_relative "jekyll-bird-plugins/file_creator"
require_relative "jekyll-bird-plugins/blog_generator"

module JekyllBirdPlugins
  class Error < StandardError; end
end
