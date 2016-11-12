def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  elsif argv[1] =~ Regexp.compile("https?://[^/]+[-a-zA-Z0-9./]+")
    h = HttpRequest.new
    resp = h.get(argv[1])
    eval resp.body
  else
    file = File.open(argv[1])
    eval file.read
  end
end
