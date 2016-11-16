class File
  class << self
    def run(uri)
      query = {}
      parser = HTTP::Parser.new
      parser.parse_url(uri).query.split('&').each do |q|
        a = q.split('=')
        query[a[0].to_sym] = a[1]
      end
      m = OnigRegexp.new("file://([^/]+[-a-zA-Z0-9]+)").match(uri)

      body = File.open(m[1]).read
      define = eval body
      define._run(query)
    end
  end
end

