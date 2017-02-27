module Tr3llo
  module API
    module User
      extend self

      def find(user_id)
        url = "/members/#{user_id}"

        JSON.parse(
          client.get(
            url,
            key: key,
            token: token
          ),
          symbolize_names: true
        )
      end

      private

      def key
        $container.resolve(:configuration).api_key
      end

      def token
        $container.resolve(:configuration).api_token
      end

      def client
        $container.resolve(:api_client)
      end
    end
  end
end
