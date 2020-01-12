require 'uri'
require 'net/http'
require 'openssl'
require '3llo/http/request_error'

module Tr3llo
  module HTTP
    module Client
      extend self

      BASE_URL = "https://api.trello.com/1"

      def get(path, params = {})
        uri = URI("#{BASE_URL}#{path}?#{query_string(params)}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)

        res = http.request(request)

        case res
        when Net::HTTPSuccess then res.body
        else raise(RequestError.new(res.body))
        end
      end

      def post(path, params)
        uri = URI("#{BASE_URL}#{path}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req_headers = {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
        }
        request = Net::HTTP::Post.new(uri.request_uri, req_headers)
        request.body = JSON.dump(params)

        res = http.request(request)

        case res
        when Net::HTTPOK then res.body
        else raise(RequestError.new(res.body))
        end
      end

      def put(path, params)
        uri = URI("#{BASE_URL}#{path}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req_headers = {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
        }
        request = Net::HTTP::Put.new(uri.request_uri, req_headers)
        request.body = JSON.dump(params)

        res = http.request(request)

        case res
        when Net::HTTPOK then res.body
        else raise(RequestError.new(res.body))
        end
      end

      def delete(path, params)
        uri = URI("#{BASE_URL}#{path}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req_headers = {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
        }
        request = Net::HTTP::Delete.new(uri.request_uri, req_headers)
        request.body = JSON.dump(params)

        res = http.request(request)

        case res
        when Net::HTTPOK then res.body
        else raise(RequestError.new(res.body))
        end
      end

      private

      def query_string(params)
        URI.encode_www_form(params)
      end
    end
  end
end
