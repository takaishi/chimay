module Chimay
  class Script
    class << self
      def define(&block)
        new.instance_eval(&block)
      end
    end

    def run
      yield
    end
  end
end
