module TxNlp
  class Keyword < Base
    def initialize(text, action_type = 'KeywordsExtraction')
      @action_type = action_type
      @encode_text = text.tr("\n", ' ')
      @escape_text = CGI.escape(@encode_text)
    end

    def raw_result
      if json['Response']['Error']
        json
      else
        original_data = json['Response']["Keywords"]
      end
    end

    def indent_result
      if json['Response']['Error']
        json
      else
        new_content = raw_result.join(',')

        new_content
      end
    end
  end

end
