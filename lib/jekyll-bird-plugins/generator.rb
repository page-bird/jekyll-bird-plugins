require "jekyll"

module JekyllBirdPlugins
  class PageBirdGenerator < Jekyll::Generator
    safe true

    def generate(site)
      jekyll_config = site.config['page_bird']
      warn "No config for Page Bird Data Fetch".yellow && return if !jekyll_config || !jekyll_config['website_id']

      page_bird_data_fetch = Importer.call(jekyll_config)
      site.data["bird"] = page_bird_data_fetch

      @_file_creator ||= FileCreator.new(data: page_bird_data_fetch).call
    end
  end
end
