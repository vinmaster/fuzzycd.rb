module Fuzzycd
  module Colorize
    extend self
    PASTEL = Pastel.new

    # def format(string, color = :green)
    #   color_code = case color
    #   when :red then 31
    #   when :green then 32
    #   when :yellow then 33
    #   when :blue then 34
    #   end
    #
    #   "\e[#{color_code}m#{string}\e[0m"
    # end

    def format(string, color = :green)
      if color.class == Array
        raise 'Invalid color' unless color.all? { |c| PASTEL.valid?(c) }
        PASTEL.decorate(string, *color)
      else
        raise 'Invalid color' unless PASTEL.valid?(color)
        PASTEL.decorate(string, color)
      end
    end

    def strip(string)
      PASTEL.strip(string)
    end
  end
end
