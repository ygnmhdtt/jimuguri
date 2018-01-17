# Note: work in progress
Todo:

* parse arguments (by optparse)
* enable to use args in block

# jimuguri - very simple ruby command line tool creator

Jimuguri enables you to create simple command line tool for ruby.

## Table of Contents

* [Installation](#installation)
* [Examples](#examples)
* [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jimuguri'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jimuguri

## Examples

```ruby
# create app instance
app = Jimuguri::Cli.new(name: 'testapp', description: 'sample app created by ygnmhdtt', version: '1.0.1')

# you can add action by block
# add_action gets command_name, help_string, do_block
app.add_action 'hello', 'puts hello string' do
  puts 'hello'
end

# start
app.run ARGV
```

```
$ ruby sample.rb hello
hello
```

`help` will be auto-generated so you don't have to add_action.

```
$ ruby sample.rb help
NAME:
    testapp - sample app created by ygnmhdtt

USAGE:
    testapp command [command options] [arguments...]

VERSION:
    1.0.1

COMMANDS:
    help        Shows a list of commands or help for one command
    hello       puts hello string
```

## License

[MIT](https://github.com/ygnmhdtt/jimuguri/blob/master/LICENSE)
