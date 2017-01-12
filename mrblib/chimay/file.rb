module Chimay
  class File < Chimay::Base
    def run
      eval_script(script, query)
    end

    def script
      m = OnigRegexp.new("file://([^/]+[-a-zA-Z0-9]+)").match(@uri)
      File.open(m[1]).read
    end
  end
end
