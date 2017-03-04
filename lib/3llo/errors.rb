module Tr3llo
  class BoardNotSelectedError < RuntimeError
    def message
      "Board has not been selected. Run 'board select' to select board"
    end
  end
end
