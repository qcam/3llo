# frozen_string_literal: true

class String
  COLOR = {
    red: 31,
    blue: 34,
    green: 32,
    black: 37,
    purple: 35,
    yellow: 33,
    orange: 33
  }.freeze

  def colorize(*code)
    "\e[#{code.join(';')}m#{self}\e[0m"
  end

  def labelize(*_code)
    colorize(93)
  end

  COLOR.each_pair do |color, code|
    define_method(color) do
      colorize(code)
    end
  end

  def paint(color)
    if respond_to?(color.to_sym)
      public_send(color)
    else
      self
    end
  end

  def short
    if size > 50
      truncate(50) + '...'
    else
      self
    end
  end
end
