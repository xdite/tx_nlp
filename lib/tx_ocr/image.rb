# frozen_string_literal: true

module TxOcr
  class Image < Base
    def initialize(file_path, ocr_type = 'GeneralBasicOCR')
      @file_path = file_path
      @ocr_type = ocr_type

      extname = File.extname(@file_path)
      basename = File.basename(@file_path, extname)
      random_filename = Time.now.to_i.to_s
      new_filename = "#{random_filename}#{extname}"
      # 上传
      TencentCosSdk.put new_filename, file: @file_path

      @remote_image_url = "http://#{TxOcr.config[:bucket]}.cos.#{TxOcr.config[:region]}.myqcloud.com" + TxOcr.config[:parent_path] + "/#{new_filename}"

    end

    def new_filename
      extname = File.extname(@file_path)
      basename = File.basename(@file_path, extname)
      random_filename = Time.now.to_i.to_s
      "#{random_filename}#{extname}"
    end

    attr_reader :remote_image_url

    def encoded_image_url
      URI.encode(@remote_image_url)
    end
  end
end
