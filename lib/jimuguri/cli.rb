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
    init_version
    @opt = OptionParser.new
    @options = {}
  end

  # auto generate help
  def init_help
    help_proc = Proc.new do
      print_help
    end
    @cmds[:help] = help_proc
    @helps[:help] = 'Shows a list of commands or help for one command'
  end

  # auto generate version
  def init_version
    version_proc = Proc.new do
      print_version
    end
    @cmds[:version] = version_proc
    @helps[:version] = 'Shows version'
  end

  # add action by given block
  def add_action(cmd, help, &blk)
    if !block_given?
      raise 'block must be given'
    end
    @cmds[cmd.to_sym] = blk
    @helps[cmd.to_sym] = help
  end

  def add_option(short, long, message)
    @opt.on("-#{short}", "--#{long}", message) {|v| @options[long.split(' ')[0].to_sym] = v}
    puts long.to_sym
  end

  def run(arg)
    # disable optparse default help, version
    help if arg.include?('-h') || arg.include?('--help')
    version if arg.include?('-v') || arg.include?('--version')

    # parse
    help if !@opt.parse(arg)

    action = @cmds[arg[0].to_sym]
    help if action.nil?

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

  def options
    @options
  end

  def print_version
    puts version
    exit(0)
  end

  def print_help
    puts help
    exit(0)
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
