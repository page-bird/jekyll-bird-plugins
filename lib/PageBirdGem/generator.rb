require "jekyll"

module PageBirdGem
  class PageBirdGenerator < Jekyll::Generator
    safe true

    def generate(site)
      config = site.config['page_bird_owl']
      warn "No config for Page Bird Owl".yellow && return if !config

      page_bird_owl_data = Importer.call(config: config)
      @_file_creator ||= FileCreator.new(data: page_bird_owl_data).call
    end
  end
end
