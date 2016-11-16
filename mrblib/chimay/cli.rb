module Chimay
  class CLI
    def run(argv)
      begin
        if argv[1] == "version"
          puts "v#{Chimay::VERSION}"
        else
          parsed = parse_stdin(STDIN.read.chomp)

          case parsed[:type]
            when :http
              Http.run(parsed[:payload])
            when :s3
              S3.run(parsed[:payload])
            when :file
              File.run(parsed[:payload])
            else
          end
        end
      rescue => e
        puts e
        puts e.backtrace
      end
    end

    def parse_stdin(input)
      payload = if consul_event?(input)
                  command = JSON::parse(input)[0]
                  Base64::decode(command['Payload'])
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
