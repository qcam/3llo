module Tr3llo
  module API
    module Token
      extend self

      def verify(key, token)
        client.get("/tokens/#{token}", key: key)

        true
      rescue HTTP::Client::RequestError
        false
      end

      def client
        Application.fetch_client!()
      end

      def api_key
        Application.fetch_configuration!().api_key
      end

      def api_token
        Application.fetch_configuration!().api_token
      end
    end
  end
end
