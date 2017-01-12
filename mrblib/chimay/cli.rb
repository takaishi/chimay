module Chimay
  class CLI
    def run(argv)
      begin
        if argv[1] == "version"
          puts "v#{Chimay::VERSION}"
        else
          parsed = parse_stdin(STDIN.read.chomp)
          client(parsed[:type], parsed[:payload]).run
        end
      rescue => e
        puts e
        puts e.backtrace
      end
    end

    def client(type, payload)
      Chimay.const_get(type.to_s.capitalize).new(payload)
    end

    def parse_stdin(input)
      payload = if consul_event?(input)
                  command = JSON::parse(input)[0]
                  PolarSSL::Base64.decode(command['Payload'])
                else
                  input
                end

      if http?(payload)
        {:type => :http, :payload => payload}
      elsif s3?(payload)
        {:type => :s3, :payload => payload}
      elsif file?(payload)
        {:type => :file, :payload => payload}
      else
        raise "could not match uri: #{payload}"
      end
    end

    def http?(s)
      s =~ Regexp.compile("^https?://[^/]+[-a-zA-Z0-9./]+")
    end

    def s3?(s)
      s =~ Regexp.compile("^s3://[^/]+[-a-zA-Z0-9./]+")
    end

    def file?(s)
      s =~ Regexp.compile("^file://[^/]+[-a-zA-Z0-9./]+")
    end

    def consul_event?(s)
      s =~ Regexp.compile("^\\[{.*")
    end
  end
end
