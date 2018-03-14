require 'optparse'
require 'tty'

module Fuzzycd
  class Cli
    CMD = TTY::Command.new(printer: :null)

    def initialize(*args)
      @args = args
      @options = {
        list: false
      }
      @screen = Screen.new(@options)
      @target_directory = Command.pwd
      @current_directory = Command.pwd

      parse_options!
    end

    def show_examples
      puts <<-EXAMPLES.gsub(/^  /, '')

  Examples
    * List current directory
      $ #{Colorize.format('fuzzycd -l', :green)}

    * List home directory
      $ #{Colorize.format('fuzzycd -l ~', :green)}

EXAMPLES
    end

    def parse_options!
      @parser = OptionParser.new do |opts|
        opts.banner = 'Usage fuzzycd [OPTIONS] [DIRECTORY]'

        opts.on('-l', '--list', 'List current directory') { @options[:list] = true }

        opts.on_tail('-h', '--help', 'Prints this help') do
          puts @parser
          show_examples
          exit
        end

        opts.on_tail('-v', '--version', 'Show version') do
          puts Fuzzycd::VERSION
          exit
        end
      end

      # After parsing [OPTIONS] only optional [DIRECTORY] should be left
      directory = @parser.parse!(@args)
      @target_directory = directory.first unless directory.empty?

      @parser
    end

    def run
      case
      when @options[:list]
        entries = Command.list_directory(@target_directory)
        puts entries
      else
        @screen.session do
          pwd = Command.pwd
          height, width = TTY::Screen.size
          print TTY::Cursor.move_to(0, height - 1)
          puts "Current directory: #{pwd}"
          puts "Press any key to continue"
          p @screen.process_input(@screen.read_input)
        end
      end
    rescue StandardError => e
      puts "#{Colorize.format("#{e.message} (#{e.class})", :red)}\n#{Colorize.format(e.backtrace.join("\n\t"), :red)}"
    end
  end
end
