def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  elsif argv[1] =~ Regexp.compile("https?://[^/]+[-a-zA-Z0-9./]+")
    h = HttpRequest.new
    resp = h.get(argv[1])
    eval resp.body
  elsif argv[1] =~ Regexp.compile("s3://[^/]+[-a-zA-Z0-9./]+")
    S3.run(argv[1])
  else
    file = File.open(argv[1])
    eval(file.read, nil, __FILE__, __LINE__)
  end
end
