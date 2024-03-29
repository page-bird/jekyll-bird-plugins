module Jekyll
  class EventsGenerator < Generator
    safe true

    def generate(site)
      if site.data["bird"]["events_active"] && site.data["bird"]["events_active"].any?
        warn "Bird starting EventsGenerator...".cyan
        dir = site.config['page_bird']['events']['index']
        
        records = site.data["bird"]["events_active"]
        records.each do |record|
          site.pages << EventPage.new(site, site.source, dir, record)
        end

        if (dir != "events") || !File.exist?(site.in_source_dir("events.html"))
          site.pages << EventsIndexPage.new(site, site.source, dir, original: true)
        end
      end
    end
  end

  class EventPage < Page
    def initialize(site, base, dir, record)
      @site = site
      @base = base
      @dir = dir
      @name = record["slug"] + ".html"
      @path = if File.exist?(site.in_source_dir("_layouts", "event.html"))
                site.in_source_dir("_layouts", "event.html")
              else
                site.in_theme_dir("_layouts", "event.html")
              end

      process(@name)
      read_yaml(@path, "")
      data["title"] = record["name"]
      data["description"] = record["preview_description"]
      data["image_url"] = record["media_url"]
      data["date"] = record["start_at"]
      data["resource"] = record

      warn "  Bird generated an Event: #{ self.data['title'] }".cyan
    end
  end

  class EventsIndexPage < Page
    def initialize(site, base, dir, original: false)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"
      @path = if File.exist?(site.in_source_dir("_layouts", "events_index.html"))
                site.in_source_dir("_layouts", "events_index.html")
              else
                site.in_theme_dir("_layouts", "events_index.html")
              end

      process(@name)
      read_yaml(@path, "")
      site_name = site.data["bird"]["name"]
      data["title"] = site_name + " | Events"

      if original
        warn "  Bird generated a EventsIndex".cyan
      end
    end
  end
end