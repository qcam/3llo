module Tr3llo
  module Application
    extend self

    DEFAULT_CONFIG_FILE_PATH = "~/.3llo.config.json"

    def start(args)
      $container = Container.new()

      interface = register_interface!()
      option_parser = build_option_parser()
      register_api_client!()

      options = parse_cli_args!(option_parser, args)

      if options.key?(:help)
        execute_help!(option_parser, interface)
        exit
      end

      if options.key?(:configure)
        execute_configure!(interface)
        exit
      end

      init_command = options.fetch(:init, "")
      config_file = options.fetch(:config, DEFAULT_CONFIG_FILE_PATH)

      print_help!(interface)

      load_configuration!(config_file, interface)
      register_registry!()

      load_user!(interface)

      Controller.start(init_command)
    end

    def execute_help!(parser, interface)
      interface.puts(parser.help)
    end

    def execute_configure!(interface)
      interface.puts("Please key in the following information:")
      interface.puts("Tips: Visit https://trello.com/app-key to obtain the credentials.\n\n")

      key = interface.input.ask("API key:", required: true)
      token = interface.input.ask("API token:", required: true)

      if API::Token.verify(key, token)
        file_content = JSON.dump({"key" => key, "token" => token})
        File.write(File.expand_path(DEFAULT_CONFIG_FILE_PATH), file_content)

        message = "Configuration has been saved to" + DEFAULT_CONFIG_FILE_PATH.green + "."
        interface.puts(message)
      else
        error_message = "Either key or token is invalid. Please try again."
        interface.puts(error_message.red)
      end
    end

    def parse_cli_args!(parser, args)
      options = {}
      parser.parse!(args, into: options)

      options
    rescue OptionParser::InvalidArgument, OptionParser::InvalidOption => exception
      {}
    end

    def build_option_parser()
      OptionParser.new do |parser|
        parser.on("-h", "--help", "show this message")
        parser.on("-i", "--init=INIT", String, "the init command to run when the program starts")
        parser.on("-c", "--config=CONFIG", String, "file path to the config file")
        parser.on("--configure", "set up configuration")
      end
    end

    def print_help!(interface)
      Presenter::HelpPresenter.print!(interface)
    end

    def register_api_client!()
      $container.register(:api_client, Tr3llo::HTTP::Client)
    end

    def register_interface!()
      prompt = TTY::Prompt.new()
      $container.register(:interface, Tr3llo::Interface.new(prompt, $stdout))
    end

    def load_configuration!(config_file, interface)
      config_path = File.expand_path(config_file)

      config =
        if File.exists?(config_path)
          JSON.load(File.read(config_path))
        else
          {}
        end

      configuration = Tr3llo::Configuration.new

      configuration.api_key = get_config_entry(config, "key", "TRELLO_KEY")
      configuration.api_token = get_config_entry(config, "token", "TRELLO_TOKEN")

      configuration.finalize!()

      $container.register(:configuration, configuration)
    rescue KeyError => exception
      command_string = "3llo --configure"
      abort "#{exception.key.inspect} has not been configured. Please run #{command_string.inspect} to set up configuration.".red
    end

    def get_config_entry(config, key, env_key)
      config.fetch(key) do
        if ENV.has_key?(env_key)
          Utils.deprecate!(
            "Setting #{env_key.inspect} as an environment variable is deprecated. It will be removed in the future versions of 3llo. Please use config file instead."
          )

          ENV.fetch(env_key)
        else
          raise KeyError.new(key: key)
        end
      end
    end

    def register_registry!()
      $container.register(:registry, Tr3llo::Registry.new)
    end

    def fetch_board!()
      $container.resolve(:board)
    rescue ::Container::KeyNotFoundError
      raise BoardNotSelectedError
    end

    def fetch_user!()
      $container.resolve(:user)
    end

    def fetch_configuration!()
      $container.resolve(:configuration)
    end

    def fetch_interface!()
      $container.resolve(:interface)
    end

    def fetch_client!()
      $container.resolve(:api_client)
    end

    def fetch_registry!()
      $container.resolve(:registry)
    end

    def load_user!(interface)
      user = Tr3llo::API::User.find("me")
      decorated_username = "@#{user.username}".yellow

      interface.print_frame do
        interface.puts("You're logged in as #{decorated_username}")
      end

      $container.register(:user, user)
    end
  end
end
