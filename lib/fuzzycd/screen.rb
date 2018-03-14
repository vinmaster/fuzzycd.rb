require 'optparse'
require 'tty'

module Fuzzycd
  class Screen
    def initialize(options = {})
      @options = options
    end

    def session
      system 'tput smcup'
      yield
      system 'tput rmcup'
    end

    def read_input
      STDIN.echo = false
      STDIN.raw!
      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
      STDIN.echo = true
      STDIN.cooked!
      input
    end

    def process_input(input)
      case input
      when " "
        return "SPACE"
      when "\t"
        return "TAB"
      when "\r"
        return "RETURN"
      when "\n"
        return "LINE FEED"
      when "\e"
        return "ESCAPE"
      when "\e[A"
        return "UP ARROW"
      when "\e[B"
        return "DOWN ARROW"
      when "\e[C"
        return "RIGHT ARROW"
      when "\e[D"
        return "LEFT ARROW"
      when "\177"
        return "BACKSPACE"
      when "\004"
        return "DELETE"
      when "\e[3~"
        return "ALTERNATE DELETE"
      when "\u0003"
        # exit 0
        return "CONTROL-C"
      when /^.$/
        # return "SINGLE CHAR HIT: #{input.inspect}"
        return input
      else
        return "SOMETHING ELSE: #{input.inspect}"
      end
    end
  end
end
