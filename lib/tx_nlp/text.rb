# frozen_string_literal: true

module TxNlp
  class Text < Base
    def initialize(text, action_type = 'SimilarWords')
      @action_type = action_type
      @encode_text = text.tr("\n", ' ')
      @escape_text = CGI.escape(@encode_text)
    end

    def raw_result
      if json['Response']['Error']
        json
      else
        original_data = json['Response']["SimilarWords"]
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
