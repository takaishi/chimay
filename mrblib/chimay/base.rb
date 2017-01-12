module Chimay
  class Base
    def initialize(uri)
      @uri = uri
    end

    def query
      query = {}
      parser = HTTP::Parser.new
      parsed = parser.parse_url(@uri)
      if parsed.query
        parsed.query.split('&').each do |q|
          a = q.split('=')
          query[a[0].to_sym] = a[1]
        end
      end
      query
    end

    def eval_script(script, query = {})
      eval(script)._run(query)
    end
  end
end