module Chimay
  class Base
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
