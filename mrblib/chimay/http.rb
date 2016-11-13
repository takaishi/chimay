class Http
  class << self
    def run(uri)
      h = HttpRequest.new
      resp = h.get(uri.chomp)
      eval resp.body
    end
  end
end

