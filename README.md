# Chaoite

A Collector and reported for Graphite. It has 2 types of collector

1. HTTP 
2. Shell

## HTTP

Pass in a Check URL which will be hit and send metrics based on status code 

## Shell

Execute a given shell command and send metrics based on return status

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chaoite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chaoite

## Usage

    $ bundle exec chaoite
    
```
Usage: chaoite [options]
    -c, --config-file config_file    Path to config file. Defaults to config.json
    -g, --graphite-server server     Graphite server url. Defaults to localhost
    -p, --graphite-port port         Graphite port. Defaults to 2003
    -h, --help                       Displays Help
```
    

## Development

After checking out the repo, run `bundle install` to install dependencies. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aswinkarthik93/chaoite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

