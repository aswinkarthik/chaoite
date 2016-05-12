require 'chaoite/version'
require 'json'
require 'chaoite/handler'
require 'optparse'
require 'graphite-api'
require 'graphite-api/core_ext/numeric'

module Chaoite

  DEFAULT_OPTIONS = {
      :config_file => 'config.json',
      :server => 'localhost',
      :port => 2003
  }

  def self.run(args)
    STDOUT.sync = true

    options = DEFAULT_OPTIONS

    parser = setup_parser(options)
    parser.parse!

    if(!File.exists?(options[:config_file]))
      puts "Config file #{options[:config_file]} does not exist. see --help for usage"
      exit
    end
    configuration = JSON.parse(File.read(options[:config_file]))
    options[:server] = configuration["graphite_host"] if configuration["graphite_host"];
    options[:port] = configuration["graphite_port"] if configuration["graphite_port"];
    puts "Starting up Chaoite"

    client = GraphiteAPI.new(:graphite => "#{options[:server]}:#{options[:port]}")

    client.every 60.seconds do |c|
      configuration["configs"].each do |config|
        metric = Handler.send("#{config["type"]}_#{config["value"]}", config)
        if(metric) then
          puts "Sending metric #{metric}"
          c.metrics(metric)
        else
          puts "Empty metric for '#{config["name"]}', not sending."
        end
      end
    end

    begin
      sleep 2 while true
    rescue Interrupt => e
      puts "Shutting down Chaoite"
    end

  end

  def self.setup_parser(options)
    OptionParser.new do |opts|
      opts.banner = "Usage: chaoite [options]"

      opts.on('-c', '--config-file config_file', "Path to config file. Defaults to #{options[:config_file]}") do |config_file|
        options[:config_file] = config_file
      end

      opts.on('-g', '--graphite-server server', "Graphite server url. Defaults to #{options[:server]}") do |server|
        options[:server] = server
      end

      opts.on('-p', '--graphite-port port', "Graphite port. Defaults to #{options[:port]}") do |port|
        options[:port] = port
      end

      opts.on('-h', '--help', 'Displays Help') do
        puts opts
        exit
      end

      opts.on('-v', '--version', 'Displays version string') do
        puts Chaoite::VERSION
        exit
      end
    end
  end
end
