module Tr3llo
  module HTTP
    module Client
      class RequestError < ::StandardError
        attr_reader :response

        def initialize(response)
          @response = response
          super()
        end

        def message
          "Request error: #{response}"
        end
      end
    end
  end
end
