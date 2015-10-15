require 'net/http'

module Handler
  def self.http_state config
    key = config["key"]
    value = begin
      res = Net::HTTP.get_response(URI(config["check"]))
      res.code == '200' ? 1 : 0
    rescue
      0
    end
    return key => value
  end

  def self.http_metric config
    key = config["key"]
    value = begin
      res = Net::HTTP.get_response(URI(config["check"]))
      res.body
    rescue
      nil
    end
    return key => value
  end

  def self.shell_state config
    key = config["key"]
    command = config["check"]
    value = system(command) ? 1 : 0
    return key => value
  end

  def self.shell_metric config
    key = config["key"]
    command = config["check"]

    value = begin
      `#{command}`
    rescue
      nil
    end

    return key => value
  end
end