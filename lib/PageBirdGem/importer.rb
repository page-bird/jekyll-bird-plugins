require 'json'
require 'open-uri'

module PageBirdGem
  class Importer
    def self.call(config: config)
      @_data ||= JSON.load(open(endpoint(config)))
    end

    private
      def self.endpoint config
        "http://localhost:3000/api/w/" + config["website"].to_s
      end
  end
end
