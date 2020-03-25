module JekyllBirdPlugins
  class FileCreator
    attr_reader :data

    def initialize data:
      @data = data
    end

    def call
      FileUtils.mkdir_p '_data/'
      File.open("_data/bird.yaml", 'w') do |file|
        file.write(data.to_yaml)
      end
      return true
    end
  end
end
