module Fuzzycd
  class Entry
    attr_accessor :path, :name, :type

    def initialize(options = {})
      @path = options[:path]
      @name = options[:name]
      @type = options[:type]
    end

    def [](key)
      self.instance_variable_get("@#{key}")
    end

    def []=(key, new_value)
      self.instance_variable_set("@#{key}", new_value)
    end

    def to_s
      name = @type == 'folder' ? Colorize.format(@name, :blue) + '/' : @name
      name
    end

    def inspect
      "Entry:#{'%x' % (self.object_id << 1)}(path: '#{@path}', name: '#{@name}', type: '#{@type}')"
    end
  end
end
