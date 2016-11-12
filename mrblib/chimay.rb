def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  else
    file = File.open(argv[1])
    eval file.read
  end
end
