module Chimay
  class Script
    class << self
      def define(&block)
        return new.instance_eval(&block)
      end
    end

    def run(&block)
      @block = block
      return self
    end

    def _run(args)
      @block.call(args)
    end
  end
end
