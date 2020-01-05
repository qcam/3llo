module Tr3llo
  module Application
    extend self

    def start(args)
      $container = Container.new()

      interface = register_interface!()

      options = parse_cli_args!(args)

      if options.key?(:help)
        print_help!(fetch_interface!())
        exit
      end

      print_help!(interface)

      register_api_client!()
      load_configuration!()
      register_registry!()

      load_user!(interface)

      Controller.start()
    end

    def print_help!(interface)
      Presenter::HelpPresenter.print!(interface)
    end

    def parse_cli_args!(args)
      options = {}

      OptionParser.new do |parser|
        parser.on("-h", "--help", "Display this help message")
        parser.on("-b", "--board BOARD", "Set default board")
      end.parse!(args, into: options)

      options
    end

    def register_api_client!()
      $container.register(:api_client, Tr3llo::HTTP::Client)
    end

    def register_interface!()
      prompt = TTY::Prompt.new()
      $container.register(:interface, Tr3llo::Interface.new(prompt, $stdout))
    end

    def load_configuration!()
      configuration = Tr3llo::Configuration.new
      begin
        configuration.api_key = ENV.fetch('TRELLO_KEY') { raise "Have you set TRELLO_KEY?" }
        configuration.api_token = ENV.fetch('TRELLO_TOKEN') { raise "Have you set TRELLO_TOKEN?" }
      rescue => error
        abort "Invalid configuration: \e[1m#{error.message}".colorize(31)
      end

      configuration.finalize!()

      $container.register(:configuration, configuration)
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
      decorated_username = "@#{user.username}".blue

      interface.print_frame do
        interface.puts("You're logged in as #{decorated_username}")
      end

      $container.register(:user, user)
    end
  end
end
