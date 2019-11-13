# frozen_string_literal: true

module TxNlp
  class Text < Base
    def initialize(file_url, ocr_type = 'GeneralBasicOCR')
      @ocr_type = ocr_type
      @file_url = file_url
    end

    def remote_image_url
      @file_url
    end

    def encoded_image_url
      URI.encode(@file_url)
    end
  end
end
