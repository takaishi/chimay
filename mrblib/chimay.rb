def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  else
    puts "Hello World"
  end
end
