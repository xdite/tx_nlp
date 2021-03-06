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


    desc 'tx_nlp 詞 ', '建議相似詞'
    def word(word)
      puts TxNlp::Text.new(word).indent_result
    end

    desc 'tx_nlp 句子 ', '抽取關鍵字'
    def keyword(keyword)
      puts TxNlp::Keyword.new(keyword).indent_result
    end

    private

    def display_name(name)
      puts name
    end
  end
end
