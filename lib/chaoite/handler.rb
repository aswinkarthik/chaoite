require 'net/http'
require 'jsonpath'

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
      parse(res.body, config)
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
      parse(`#{command}`, config)

    rescue
      nil
    end

    return key => value
  end

  private
  def self.parse(data, config)
    parser = config["parser"] || "text"
    self.send("parse_#{parser}", data, config)
  end

  def self.parse_text(data, config)
    return data
  end

  def self.parse_json(data, config)
    raise "jsonpath needs to be specified if using json parser" if(!config["jsonpath"])
    return JsonPath.on(data, config["jsonpath"])[0]
  end
end
