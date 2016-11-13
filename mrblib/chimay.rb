def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  else
    input = STDIN.read

    if input =~ Regexp.compile("^https?://[^/]+[-a-zA-Z0-9./]+")
      Http.run(argv[1])
    elsif input =~ Regexp.compile("^s3://[^/]+[-a-zA-Z0-9./]+")
      S3.run(argv[1])
    else
      eval(input, nil, __FILE__, __LINE__)
    end
  end
end
