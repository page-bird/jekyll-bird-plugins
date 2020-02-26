require 'json'
require 'open-uri'

module JekyllBirdDataFetch
  class Importer
    def self.call(config: config)
      @_data ||= JSON.load(open(endpoint(config)))
    end

    private
      def self.endpoint config
        "https://www.page-bird.com/api/w/" + config["website"].to_s
      end
  end
end
