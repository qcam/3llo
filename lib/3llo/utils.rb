module Tr3llo
  module Utils
    extend self

    def format_key_tag(id, shortcut)
      shortcut_prefix = Entities::SHORTCUT_PREFIX
      formatted_shortcut = (shortcut_prefix + shortcut)

      "[#{id.blue} #{formatted_shortcut.labelize}]"
    end

    def assert_string!(data, message)
      raise InvalidArgumentError.new(message) unless data.is_a?(String)
    end

    def format_user(user)
      ("@" + user.username).blue
    end
  end
end
