# frozen_string_literal: true

module TxNlp
  class Text < Base
    def initialize(text, action_type = 'SimilarWords')
      @action_type = action_type
      @encode_text = text.tr("\n", ' ')
      @escape_text = CGI.escape(@encode_text)
    end

  end
end
