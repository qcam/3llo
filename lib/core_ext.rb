class String

  # Trello label color names:
  #   https://trello.com/c/ZAvI05TG/94-label-color-names-sticker-names
  #
  # Terminal color codes:
  #   https://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
  COLOR = {
    red: 31,
    pink: 31,
    blue: 34,
    green: 32,
    lime: 32,
    black: 37,
    white: 37,
    purple: 35,
    yellow: 33,
    orange: 33,
    cyan: 36,
    sky: 36
  }.freeze

  def colorize(*code)
    "\e[#{code.join(";")}m#{self}\e[0m"
  end

  def labelize(*code)
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
    if self.size > 50
      self.truncate(50) + "..."
    else
      self
    end
  end
end
