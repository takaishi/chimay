def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  else
    parsed = parse_stdin(STDIN.read)

    if parsed[:type] == :http
      Http.run(parsed[:payload])
    elsif parsed[:type] == :s3
      S3.run(parsed[:payload])
    elsif parsed[:type] == :file
      File.run(parsed[:payload])
    else
    end
  end
end

def parse_stdin(input)
  if input =~ Regexp.compile("^https?://[^/]+[-a-zA-Z0-9./]+")
    {:type => :http, :payload => input}
  elsif input =~ Regexp.compile("^s3://[^/]+[-a-zA-Z0-9./]+")
    {:type => :s3, :payload => input}
  elsif input =~ Regexp.compile("^file://[^/]+[-a-zA-Z0-9./]+")
    {:type => :file, :payload => input}
  else
    command = JSON::parse(input)
    payload =  Base64::decode(@command['Payload'])
    if payload =~ Regexp.compile("^https?://[^/]+[-a-zA-Z0-9./]+")
      {:type => :http, :payload => payload}
    elsif payload =~ Regexp.compile("^s3://[^/]+[-a-zA-Z0-9./]+")
      {:type => :s3, :payload => payload}
    elsif input =~ Regexp.compile("^file://[^/]+[-a-zA-Z0-9./]+")
      {:type => :file, :payload => input}
    else
    end
  end
end
