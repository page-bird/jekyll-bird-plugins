require 'json'
require 'open-uri'

module JekyllBirdPlugins
  class Importer
    def self.call jekyll_config
      @_data ||= JSON.load(open(endpoint(jekyll_config)))
    end

    def self.endpoint jekyll_config
      base = jekyll_config["api_host"] || "https://www.page-bird.com"
      host = base + "/api/w/" + jekyll_config["website_id"].to_s
      warn "Bird Fetching Data from: #{ host }".green
      return host
    end
  end
end
