module Tr3llo
  class BoardNotSelectedError < ::RuntimeError
    def message
      "Board has not been selected. Run 'board select' to select board"
    end
  end

  class EmptyListError < ::RuntimeError
    def message
      "There is no list. Run 'list add' to create one"
    end
  end

  class InvalidCommandError < ::ArgumentError; end

  class InvalidArgumentError < ::ArgumentError; end
end
