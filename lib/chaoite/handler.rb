require 'net/http'

module Handler
  def self.http_state config

    key = config["key"]
    begin
      res = Net::HTTP.get_response(URI(config["url"]))
      value = res.code == '200' ? 1 : 0
    rescue
      value = 0
    end
    return  key => value
  end

  def self.http_metric config

    key = config["key"]
    begin
      res = Net::HTTP.get_response(URI(config["url"]))
      value = res.body
    rescue
      value = nil
    end
    return  key => value
  end

end