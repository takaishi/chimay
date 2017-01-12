module Chimay
  class Http < Chimay::Base
    def run
      eval_script(script, query)
    end

    def script
      h = HttpRequest.new
      parser = HTTP::Parser.new
      parsed = parser.parse_url(@uri)
      resp = h.get("#{parsed.schema}://#{parsed.host}#{parsed.path}")
      resp.body
    end
  end
end
