require "3llo"

module IntegrationSpecHelper
  def execute_command(command)
    Tr3llo::Command.execute(command)
  end

  def build_container(configuration: configuration_mock(), registry: Tr3llo::Registry.new())
    container = Container.new()
    container.register(:configuration, configuration)
    container.register(:registry, registry)

    container
  end

  def configuration_mock()
    double(:configuration, api_key: "foo", api_token: "bar")
  end

  def make_client_mock(container)
    client_mock = double(:http_client)
    yield(client_mock)
    container.register(:api_client, client_mock)
  end

  def make_interface(container, input: double(:input), output: StringIO.new())
    interface = Tr3llo::Interface.new(input, output)

    yield(input, output) if block_given?()

    container.register(:interface, interface)
  end

  def sign_in(container, user)
    container.register(:user, user)
  end

  def select_board(container, board)
    container.register(:board, board)
  end

  def make_board(board_id)
    Tr3llo::Entities::Board.new(board_id)
  end

  def make_user(user_id)
    Tr3llo::Entities::User.new(user_id)
  end
end
