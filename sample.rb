require_relative './lib/jimuguri'

class Test
 
  def run
    app = Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt')
    app.add_action 'hello', 'puts hello string' do
      puts 'hello'
    end
    app.run ARGV
  end

  Test.new.run

end
