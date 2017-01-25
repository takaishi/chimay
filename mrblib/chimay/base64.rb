module Chimay
  class Base64
    class << self
      def encode(s)
        PolarSSL::Base64.encode(s)
      end

      def decode(s)
        PolarSSL::Base64.decode(s)
      end
    end
  end
end
