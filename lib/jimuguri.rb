require "jimuguri/version"

module Jimuguri
  class Cli
    def initialize(name: 'sampleapp', 
        description: 'sample app created by jimuguri',
        version: '0.0')
      @name = name
      @description = description
      @version = version
      @cmds = {}
      help_proc = Proc.new do
        help
      end
      @cmds[:help] = help_proc
    end

    def add_action(cmd, help, &blk)
      p cmd
      @cmds[cmd.to_sym] = blk
    end

    def name
      @name
    end

    def description
      @description
    end

    def version
      @version
    end
  end
end
