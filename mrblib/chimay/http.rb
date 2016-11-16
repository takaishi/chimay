class Http
  class << self
    def run(uri)
      query = {}
      parser = HTTP::Parser.new
      parsed = parser.parse_url(uri)
      parsed.query.split('&').each do |q|
        a = q.split('=')
        query[a[0].to_sym] = a[1]
      end

      h = HttpRequest.new
      resp = h.get("#{parsed.schema}://#{parsed.host}#{parsed.path}")
      define = eval resp.body
      define._run(query)
    end
  end
end
