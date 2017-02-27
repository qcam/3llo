class Container
  class KeyNotFoundError < ::KeyError
    attr_reader :key

    def initialize(key)
      @key = key
      super
    end
  end

  def initialize
    @data = {}
  end

  def resolve(key)
    @data.fetch(key)
  rescue ::KeyError
    raise KeyNotFoundError.new(key)
  end

  def register(key, value)
    @data[key] = value
  end
end
