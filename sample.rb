require_relative './lib/jimuguri'

class Test
 
  def run
    app = Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt')
    app.add_action 'demo1', 'shows demonstration of jimuguri' do
      puts "options: #{app.options.to_s}"
      puts "options class: #{app.options.class}"
      puts "options is nil: #{app.options.nil?}"
    end

    app.add_action 'demo2', 'shows demonstration of jimuguri' do
      puts "options[:force]: #{app.options[:force]}"
      puts "options[:force] class: #{app.options[:force].class}"
      puts "options[:force] is nil: #{app.options[:force].nil?}"
    end

    app.add_action 'demo3', 'shows demonstration of jimuguri' do
      puts "options[:output]: #{app.options[:output]}"
      puts "options[:output] class: #{app.options[:output].class}"
      puts "options[:output] is nil: #{app.options[:output].nil?}"
    end

    app.add_action 'demo4', 'shows demonstration of jimuguri' do
      puts "options[:message]: #{app.options[:message]}"
      puts "options[:message] class: #{app.options[:message].class}"
      puts "options[:message] is nil: #{app.options[:message].nil?}"
    end

    app.add_option 'f', 'force', 'Do something force'
    app.add_option 'o FILENAME', 'output FILENAME(required)', 'Specify output file.'
    app.add_option 'm [message]', 'message [message](optional)', 'Shows message if passed'
    app.run ARGV
  end

  Test.new.run

end
