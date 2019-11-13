require 'thor'
require 'active_support/core_ext/string'
require 'tx_nlp'

module TxNlp
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../..', __dir__)
    end

    desc 'config', 'change settings'
    def config

      config_path = Dir.home + '/.tx_nlp'
      if Dir.exist?(config_path)
        puts "Your current name is [#{TxNlp.config[:name]}]."
      else
        template 'templates/settings.yml.tt', "http://#{config_path}/settings.yml"
      end
    end

    desc 'tx_nlp image FILENAME ', '翻译图片'
    def image(filename)
      puts TxNlp::Image.new(filename).indent_result
    end

    desc 'tx_nlp url URL ', '翻译网址图片'
    def url(url)
      puts TxNlp::Text.new(url).indent_result
    end

    private

    def display_name(name)
      puts name
    end
  end
end
