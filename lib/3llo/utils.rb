module Tr3llo
  module Utils
    extend self

    COLOR = {
      "red" => 31,
      "pink" => 31,
      "blue" => 34,
      "green" => 32,
      "lime" => 32,
      "black" => 37,
      "white" => 37,
      "purple" => 35,
      "yellow" => 33,
      "orange" => 33,
      "cyan" => 36,
      "sky" => 36
    }.freeze()

    TRELLO_LABEL_COLOR = %w[red pink blue green purple yellow orange sky].freeze()

    def format_key_tag(id, shortcut)
      formatted_shortcut = Utils.format_highlight(Entities::SHORTCUT_PREFIX + shortcut)
      formatted_id = Utils.paint(id, "blue")

      "[#{formatted_id} #{formatted_shortcut}]"
    end

    def assert_string!(data, message)
      raise InvalidArgumentError.new(message) unless data.is_a?(String)
    end

    def assert_list!(list)
      raise EmptyListError if list.size.zero?
    end

    def format_user(user)
      Utils.paint("@" + user.username, "blue")
    end

    def deprecate!(message)
      interface = Application.fetch_interface!()

      interface.puts(Utils.paint("DEPRECATED: #{message}", "yellow"))
    end

    def paint(string, color)
      code = COLOR.fetch(color)

      "\e[#{code}m#{string}\e[0m"
    end

    def format_bold(string)
      "\e[1m#{string}\e[0m"
    end

    def format_dim(string)
      "\e[2m#{string}\e[0m"
    end

    def format_highlight(string)
      paint(string, "yellow")
    end

    def build_req_path(path, extra_params = {})
      params =
        {
          "key" => Application.fetch_configuration!().api_key,
          "token" => Application.fetch_configuration!().api_token
        }.merge(extra_params)

      [path, URI.encode_www_form(params)].join("?")
    end
  end
end
