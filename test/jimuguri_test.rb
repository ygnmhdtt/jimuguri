require "test_helper"

class JimuguriTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jimuguri::VERSION
  end

  def test_default_app_settings_works
    app = Cli.new
    assert app.name.eql? "sampleapp"
    assert app.description.eql? "sample app created by jimuguri"
    assert app.version.eql? "0.0"
  end

  def test_custom_app_settings_works
    name = "testapp"
    description = "test description"
    version = "1.0"
    app = Cli.new(name: name, description: description, version: version)
    assert app.name == name
    assert app.description == description
    assert app.version == version
  end

  def test_add_action_works
    app = Cli.new
    app.add_action "testaction", "action for testing" do
      print "test success!"
    end
    assert app.actions[:testaction] != nil

    # get stdout
    $stdout = StringIO.new
    app.run ["testaction"]
    output = $stdout.string
    $stdout = STDOUT

    assert output.eql? 'test success!'

  end

  # it uses optparse library to parse flag, so test should be slim
  def test_add_option_works
    app = Cli.new
    app.add_action "testaction", "action for testing" do
      print app.options[:aflag]
    end
    app.add_option "a", "aflag", "flag for test"

    # get stdout
    $stdout = StringIO.new

    app.run ["testaction", "-a"]
    output = $stdout.string
    assert output.eql? "true"
    $stdout = STDOUT
  end

end
