require 'optparse'

class Cli

  def initialize(name: 'sampleapp', 
      description: 'sample app created by jimuguri',
      version: '0.0')
    @name = name
    @description = description
    @version = version
    @cmds = {}
    @helps = {}
    init_help
  end

  # auto generate help
  def init_help
    help_proc = Proc.new do
      puts help
    end
    @cmds[:help] = help_proc
    @helps[:help] = 'Shows a list of commands or help for one command'
  end

  # add action by given block
  def add_action(cmd, help, &blk)
    if !block_given?
      raise 'block must be given'
    end
    @cmds[cmd.to_sym] = blk
    @helps[cmd.to_sym] = help
  end

  def run(arg)
    action = @cmds[arg[0].to_sym]
    if action.nil?
      puts help
      return
    end
    action.call
  end

  def actions
    @cmds
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

  def help
    generate_help
  end

  def generate_help
    commands = ""
    @helps.map {|cmd, help| commands << "    #{cmd.to_s}\t#{help}\n"}
    help_string + commands
  end

  def help_string
    <<~"HERE"
      NAME:
          #{@name} - #{@description}
      
      USAGE:
          #{@name} command [command options] [arguments...]
      
      VERSION:
          #{version}
      
      COMMANDS:
    HERE
  end
end
