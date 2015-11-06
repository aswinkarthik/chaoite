require 'net/http'
require 'jsonpath'
require 'chaoite/json_helper'

include JsonHelper

module Handler
  class << self
    def http_state config
      key = config["key"]
      value = begin
        res = Net::HTTP.get_response(URI(config["check"]))
        res.code == '200' ? 1 : 0
      rescue
        0
      end
      return key => value
    end

    def http_metric config
      begin
        res = Net::HTTP.get_response(URI(config["check"]))
        parse(res.body, config)
      rescue Exception => e
        puts e
        nil
      end
    end

    def shell_state config
      key = config["key"]
      command = config["check"]
      value = system(command) ? 1 : 0
      return key => value
    end

    def shell_metric config
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
    def parse(data, config)
      parser = config["parser"] || "text"
      self.send("parse_#{parser}", data, config)
    end

    def parse_text(data, config)
      key = config["key"]
      return key => data
    end

    def parse_json(data, config)
      raise "json parser: Invalid json recieved from target service" if (!valid_json?(data))
      key = resolve_json_path(data, config["key"])
      value = resolve_json_path(data, config["jsonvalue"])
      raise "json parser: key count should equal value count" if (key.length != value.length)
      Hash[key.zip(value)]
    end

  end
end
