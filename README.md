# jimuguri - very simple ruby command line tool creator

Jimuguri enables you to create simple command line tool for ruby.

## Table of Contents

* [Installation](#installation)
* [Description](#description)
 - [overview](#overview)
 - [add action](#add-action)
 - [add options](#add-options)
 - [other commands](#other-commands)
* [Examples](#examples)
* [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jimuguri'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install jimuguri
```

## Descriprion

### overview

```ruby
# create app instance
app = Jimuguri::Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt', version: '1.0.1')

# you can add action by block
# add_action gets command_name, help_string, do_block
app.add_action 'demo', 'show demonstration of jimuguri' do
  puts "options[:force]: #{app.options[:force]}"
  puts "options[:output]: #{app.options[:output]}"
  puts "options[:message]: #{app.options[:message]}"
end

# you can add options
# add_option gets short_option, long_option, description
app.add_option 'f', 'force', 'Do something force'
app.add_option 'o FILENAME', 'output FILENAME(required)', 'Specify output file.'
app.add_option 'm [message]', 'message [message](optional)', 'Shows message if passed'

# start
app.run ARGV
```

### create application

```ruby
app = Jimuguri::Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt', version: '1.0.1')
```
You can specify `name`, `description`, `version` .
All parameters are optional. But if you don't specify, they will be auto-generated.
Recommend to specify.

### add action

```ruby
app.add_action 'demo', 'show demonstration of jimuguri' do
  puts "options[:force]: #{app.options[:force]}"
  puts "options[:output]: #{app.options[:output]}"
  puts "options[:message]: #{app.options[:message]}"
end
```

You need to specify `command name`, `description`, `what to do` .
`description` is used by `help` .

If you want to use passed options, like this:

```ruby
puts app.options[:force]
```

Description of symbol name of options follows.

### add options

```ruby
app.add_option 'f', 'force', 'Do something force'
app.add_option 'o FILENAME', 'output FILENAME(required)', 'Specify output file.'
app.add_option 'm [message]', 'message [message](optional)', 'Shows message if passed'
```

You can specify `short_option` , `long_option` , `description` .
`description` is used by `help`.
When use it:

```sh
# short option needs 1 dash
ruby sample.rb demo -f

# long option needs 2 dashes
ruby sample.rb demo --force

# Above 2 commands work samely.
```

If you need argument, like this:

```ruby
app.add_option 'o FILENAME', 'output FILENAME(required)', 'Specify output file.'
```

If `FILENAME` is not given, it shows `help`.

You can set argument optional, like this:

```ruby
app.add_option 'm [message]', 'message [message](optional)', 'Shows message if passed'
```

Argument name with `[]` , and it will be optional.

### other commands

`help` and `version` will be auto-generated so you don't have to add_action.

```sh
$ ruby sample.rb help
NAME:
    testapp - sample app created by ygnmhdtt

USAGE:
    testapp command [command options] [arguments...]

VERSION:
    1.0.1

COMMANDS:
    help        Shows a list of commands or help for one command
    version     Shows version
    demo1       shows demonstration of jimuguri
    demo2       shows demonstration of jimuguri
    demo3       shows demonstration of jimuguri
    demo4       shows demonstration of jimuguri

OPTIONS:
    -f --force  Do something force
    -o FILENAME --output FILENAME(required)     Specify output file.
    -m [message] --message [message](optional)  Shows message if passed
```

```sh
$ ruby sample.rb version
1.0.1
```

## Examples

Sample Code:

```ruby
require_relative './lib/jimuguri'

class Test

  def run
    app = Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt', version: '1.0.1')
    app.add_action 'demo', 'shows demonstration of jimuguri' do
      puts "options: #{app.options.to_s}"
      puts "options class: #{app.options.class}"
      puts "options is nil: #{app.options.nil?}"

      puts ""

      puts "options[:force]: #{app.options[:force]}"
      puts "options[:force] class: #{app.options[:force].class}"
      puts "options[:force] is nil: #{app.options[:force].nil?}"

      puts ""

      puts "options[:output]: #{app.options[:output]}"
      puts "options[:output] class: #{app.options[:output].class}"
      puts "options[:output] is nil: #{app.options[:output].nil?}"

      puts ""

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
```

When no options passed, options will be nil.

```sh
$ ruby sample.rb demo
options: {}
options class: Hash
options is nil: false

options[:force]:
options[:force] class: NilClass
options[:force] is nil: true

options[:output]:
options[:output] class: NilClass
options[:output] is nil: true

options[:message]:
options[:message] class: NilClass
options[:message] is nil: true
```

When you specify options:

```sh
$ ruby sample.rb demo -f -o output.txt -m 'aaa'
options: {:force=>true, :output=>"output.txt", :message=>"aaa"}
options class: Hash
options is nil: false

options[:force]: true
options[:force] class: TrueClass
options[:force] is nil: false

options[:output]: output.txt
options[:output] class: String
options[:output] is nil: false

options[:message]: aaa
options[:message] class: String
options[:message] is nil: false
```

`[message]` is optional, but if given, you can get arg.

If optional arg was not given, it will be `nil` .

## License

[MIT](https://github.com/ygnmhdtt/jimuguri/blob/master/LICENSE)
