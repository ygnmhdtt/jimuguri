require 'optparse'

class Cli

  def initialize(name: 'sampleapp', 
      description: 'sample app created by jimuguri',
      version: '0.0')
    @name = name
    @description = description
    @version = version
    @cmds = {}
    @cmd_helps = {}
    init_help
    init_version
    @opt = OptionParser.new
    @options = {}
    @opt_helps = []
  end

  # auto generate help
  def init_help
    help_proc = Proc.new do
      print_help
    end
    @cmds[:help] = help_proc
    @cmd_helps[:help] = 'Shows a list of commands or help for one command'
  end

  # auto generate version
  def init_version
    version_proc = Proc.new do
      print_version
    end
    @cmds[:version] = version_proc
    @cmd_helps[:version] = 'Shows version'
  end

  # add action by given block
  def add_action(cmd, help, &blk)
    if !block_given?
      raise 'block must be given'
    end
    @cmds[cmd.to_sym] = blk
    @cmd_helps[cmd.to_sym] = help
  end

  def add_option(short, long, message)
    @opt.on("-#{short}", "--#{long}", message) {|v| @options[long.split(' ')[0].to_sym] = v}
    @opt_helps.push "-#{short} --#{long}\t#{message}"
  end

  def run(arg)
    print_help if arg.size == 0

    # disable optparse default help, version
    print_help if arg.include?('-h') || arg.include?('--help')
    print_version if arg.include?('-v') || arg.include?('--version')

    # parse
    begin
      @opt.parse!(arg)
    rescue
      print_help
    end

    action = @cmds[arg[0].to_sym]
    print_help if action.nil?

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
    # concat commands
    commands = "COMMANDS:\n"
    @cmd_helps.map {|cmd, help| commands << "    #{cmd.to_s}\t#{help}\n"}

    options = "\nOPTIONS:\n"
    @opt_helps.map {|help| options << "    #{help}\n"}

    help_string + commands + options
  end

  def help_string
    <<~"HERE"
      NAME:
          #{@name} - #{@description}
      
      USAGE:
          ruby `file_name.rb` command [command options] [arguments...]
      
      VERSION:
          #{version}
      
    HERE
  end
end
