module Tr3llo
  module Entities
    extend self

    SHORTCUT_PREFIX = "#"

    InvalidKeyError = Class.new(ArgumentError)
    InvalidIDError = Class.new(ArgumentError)

    User = Struct.new(:id, :shortcut, :username)
    Board = Struct.new(:id, :shortcut, :name)
    List = Struct.new(:id, :shortcut, :name)
    Card = Struct.new(:id, :shortcut, :name, :description, :short_url, :labels, :members, :list, keyword_init: true)
    Label = Struct.new(:name, :color)
    Comment = Struct.new(:id, :text, :creator, keyword_init: true)
    Checklist = Struct.new(:id, :shortcut, :name, :items, keyword_init: true)
    Checklist::Item = Struct.new(:id, :shortcut, :name, :state, keyword_init: true)

    def parse_id(type, key)
      if key.start_with?(SHORTCUT_PREFIX)
        shortcut = key.delete_prefix(SHORTCUT_PREFIX)

        registry.reverse_lookup(type, shortcut)
      else
        key
      end
    end

    def make_shortcut(type, id)
      if id.is_a?(String)
        registry.register(type, id)
      else
        raise ArgumentError.new("Invalid ID")
      end
    end

    private

    def registry
      Application.fetch_registry!()
    end
  end
end
