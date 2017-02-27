module Tr3llo
  class Configuration
    def initialize
      @container = Container.new
    end

    def user_id=(value)
      container.register(:user_id, value)
    end

    def user_id
      container.resolve(:user_id)
    end

    def api_key=(value)
      container.register(:api_key, value)
    end

    def api_key
      container.resolve(:api_key)
    end

    def api_token=(token)
      container.register(:api_token, token)
    end

    def api_token
      container.resolve(:api_token)
    end

    def finalize!
      container.freeze
    end

    private

    attr_reader :container
  end
end
