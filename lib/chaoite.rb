require 'chaoite/version'
require 'json'
require 'chaoite/handler'

module Chaoite
  def self.run(args)
    puts "Chaoite has started..."
    configs = JSON.parse(File.read(args))

    configs.each do |config|
      Handler.send config["type"], config
    end

  end
end
