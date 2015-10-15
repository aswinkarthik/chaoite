require 'net/http'

module Handler
  def self.http config
    puts "Http handler invoked"
    res = Net::HTTP.get_response(URI(config["url"]))

    if res.code == '200'
      puts "App is up"
    end

  end
end