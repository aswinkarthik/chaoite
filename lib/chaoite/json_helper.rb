module JsonHelper
  def resolve_json_path(json, template)
    if template.start_with?("$") then
      JsonPath.on(json, template)
    else
      paths = template.scan(/(\{(.*?)\})/).uniq
      return template if paths.empty?
      combinations = paths.map { |path| {path[0] => JsonPath.on(json, path[1])} }.reduce(&:merge)

      combinations = combinations.values[0].product(*combinations.values[1..-1]).map{ |x| Hash[combinations.keys.zip(x)] }

      combinations.map do |c|
        t = template+''
        c.keys.each do |key|
          t.gsub!(key, c[key])
        end
        t
      end
    end
  end

  def valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue Exception => e
      return false
    end
  end
end