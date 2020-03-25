require 'json'
require 'open-uri'

module JekyllBirdDataFetch
  class Importer
    def self.call jekyll_config
      @_data ||= JSON.load(open(endpoint(jekyll_config)))
    end

    def self.endpoint jekyll_config
      host = jekyll_config["api_host"] || "https://www.page-bird.com"
      host + "/api/w/" + jekyll_config["website_id"].to_s
    end
  end
end
