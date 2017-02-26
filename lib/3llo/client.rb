require 'uri'
require 'net/http'
require 'openssl'

module Tr3llo
  module Client
    extend self

    BASE_URL = "https://api.trello.com/1"

    class RequestError < RuntimeError
      attr_reader :response

      def initialize(response)
        @response = response
        super()
      end

      def message
        "Request error: #{response}"
      end
    end

    def get(path, params = {})
      uri = URI("#{BASE_URL}#{path}?#{query_string(params)}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)

      res = http.request(request)

      case res
      when Net::HTTPSuccess then res.body
      else raise(RequestError.new(res.body))
      end
    end

    def put(path, params)
      uri = URI("#{BASE_URL}#{path}?#{query_string(params)}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Put.new(uri.request_uri)

      res = http.request(request)

      case res
      when Net::HTTPOK then res.body
      else raise(RequestError.new(res.body))
      end
    end

    private

    def query_string(params)
      params.keys.map { |key| "#{key}=#{params[key]}" }.join("&")
    end
  end
end
