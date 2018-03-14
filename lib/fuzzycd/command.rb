require 'optparse'
require 'tty'

module Fuzzycd
  module Command
    extend self
    CMD = TTY::Command.new(printer: :null)

    def run(command, options = {})
      output, err = CMD.run(command, options)
      raise err unless err.empty?
      output
    end

    def pwd
      run('pwd').delete!("\n")
    end

    def list_directory(directory)
      raise "'#{directory}' does not exist" unless File.exists?(directory)
      raise "'#{directory}' is not a folder" unless File.directory?(directory)

      output = Dir.entries(directory).map do |entry|
        path = File.join(directory, entry)
        if File.directory?(path)
          Entry.new(path: path, name: entry, type: 'folder')
        else
          Entry.new(path: path, name: entry, type: 'file')
        end
      end
    end
  end
end
