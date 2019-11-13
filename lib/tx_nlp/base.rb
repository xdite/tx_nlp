# frozen_string_literal: true
require 'httparty'
require 'json'
require 'cgi'
require 'uri'
require 'tencent_cos_sdk'

module TxNlp
  class Base
    HOST = 'nlp.tencentcloudapi.com'

    TencentCosSdk.configure do |conf|
      conf.secret_id      = TxNlp.config[:secret_id]
      conf.secret_key     = TxNlp.config[:secret_key]
      conf.host = "#{TxNlp.config[:bucket]}.cos.#{TxNlp.config[:region]}.myqcloud.com"
    end


    def region
      TxNlp.config[:region]
    end

    def url
      "https://#{HOST}"
    end

    def secret_id
      TxNlp.config[:secret_id]
    end

    def secret_key
      TxNlp.config[:secret_key]
    end

    def orginal_parameters
      new_hash = fixed_paramaters
      new_hash['Action'] = @action_type
      new_hash['Text'] = @encode_text
      to_params(new_hash)
    end

    def encode_parameters
      new_hash = fixed_paramaters
      new_hash['Action'] = @action_type
      new_hash['Text'] = @escape_text
      to_params(new_hash)
    end

    def fixed_paramaters
      { 'Nonce' => '2373', 'Region' => region, 'SecretId' => secret_id, 'Timestamp' => Time.now.to_i.to_s, 'Version' => '2019-04-08' }
    end

    def to_params(original_hash)
      sorted_by_key = Hash[original_hash.sort]
      sorted_by_key.map { |x| "#{x[0]}=#{x[1]}" }.join('&')
    end

    def string_for_sign
      "GET#{HOST}/?" + orginal_parameters
    end

    def signature
      digest = OpenSSL::Digest.new('sha1')
      hmac = OpenSSL::HMAC.digest(digest, secret_key, string_for_sign)
      encrypt = Base64.encode64(hmac).delete("\n")
      encrypt.gsub('+', '%2B') # 处理 + 号
    end

    def request_params
      "/?#{encode_parameters}&Signature=#{signature}"
    end

    def full_request_url
      url + request_params
    end

    def request_object
      HTTParty.get(url + request_params)
    end

    def json
      JSON.parse(request_object.body)
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
