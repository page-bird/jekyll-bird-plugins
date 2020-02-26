require "jekyll"

module JekyllBirdDataFetch
  class PageBirdGenerator < Jekyll::Generator
    safe true

    def generate(site)
      config = site.config['page_bird_data_fetch']
      warn "No config for Page Bird Data Fetch".yellow && return if !config

      page_bird_data_fetch = Importer.call(config: config)
      site.data["bird"] = page_bird_data_fetch

      @_file_creator ||= FileCreator.new(data: page_bird_data_fetch).call
    end
  end
end
