class File
  class << self
    def run(uri)
      m = OnigRegexp.new("file://([^/]+[-a-zA-Z0-9]+)").match(uri)

      body = File.open(m[1]).read
      eval body
    end
  end
end

