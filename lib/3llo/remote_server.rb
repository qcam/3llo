require "net/http"

module Tr3llo
  class RemoteServer
    attr_reader :endpoint_url

    EXPECTED_CODES = ["200"].freeze

    class RequestError < ::StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super()
      end

      def message
        formatted_response = "status: " + response.code.inspect() + ", body: " + response.body.inspect()

        "Received unexpected response from remote server: " + formatted_response
      end
    end

    def initialize(endpoint_url)
      @endpoint_url = endpoint_url
    end

    def get(req_path, req_headers, expected_codes = EXPECTED_CODES)
      req_uri = build_request_uri(req_path)
      req_headers = {"accept" => "application/json"}.merge(req_headers)

      dispatch(Net::HTTP::Get.new(req_uri, req_headers), expected_codes)
    end

    def post(req_path, req_headers, payload, expected_codes = EXPECTED_CODES)
      req_uri = build_request_uri(req_path)

      req_headers = {
        "accept" => "application/json",
        "content-type" => "application/json"
      }.merge(req_headers)

      request = Net::HTTP::Post.new(req_uri, req_headers)
      request.body = JSON.dump(payload)

      dispatch(request, expected_codes)
    end

    def put(req_path, req_headers, payload, expected_codes = EXPECTED_CODES)
      req_uri = build_request_uri(req_path)

      req_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }.merge(req_headers)

      request = Net::HTTP::Put.new(req_uri, req_headers)
      request.body = JSON.dump(payload)

      dispatch(request, expected_codes)
    end

    def delete(req_path, req_headers, payload, expected_codes = EXPECTED_CODES)
      req_uri = build_request_uri(req_path)

      req_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }.merge(req_headers)

      request = Net::HTTP::Delete.new(req_uri, req_headers)
      request.body = JSON.dump(payload)

      dispatch(request, expected_codes)
    end

    private

    def build_request_uri(req_path)
      URI.parse(endpoint_url + req_path)
    end

    def dispatch(request, expected_status_codes)
      req_uri = request.uri

      Net::HTTP.start(req_uri.host, req_uri.port, use_ssl: req_uri.scheme == "https") do |http|
        response = http.request(request)

        if expected_status_codes.include?(response.code)
          JSON.parse(response.body)
        else
          raise RequestError.new(response)
        end
      end
    end
  end
end
