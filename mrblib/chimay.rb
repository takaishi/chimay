def __main__(argv)
  if argv[1] == "version"
    puts "v#{Chimay::VERSION}"
  elsif argv[1] =~ Regexp.compile("https?://[^/]+[-a-zA-Z0-9./]+")
    h = HttpRequest.new
    resp = h.get(argv[1])
    eval resp.body
  elsif argv[1] =~ Regexp.compile("s3://[^/]+[-a-zA-Z0-9./]+")
    m = OnigRegexp.new("s3://([^/]+[-a-zA-Z0-9]+)(/[^/]+[-a-zA-Z0-9./]+)").match(argv[1])

    AWSAccessKeyId = aws_access_key_id
    AWSSecretAccessKey = aws_secret_access_key
    AWSBucket = m[1]

    aws = AWS::S3.new(AWSAccessKeyId, AWSSecretAccessKey)
    aws.set_bucket(AWSBucket)
    resp = aws.download(m[2])
    if resp.code.to_i == 200
      eval resp.body
    else
      puts "Error code = #{resp.code}"
      puts "Error body = #{resp.body}"
    end
  else
    file = File.open(argv[1])
    eval file.read
  end
end

def aws_access_key_id
  if ENV['AWS_ACCESS_KEY_ID']
     ENV['AWS_ACCESS_KEY_ID']
  else
    cred = File.open("#{ENV['HOME']}/.aws/credentials").read
    m = OnigRegexp.new('aws_access_key_id\s?=\s?(.*)').match(cred)
    m[1]
  end
end

def aws_secret_access_key
  if ENV['AWS_SECRET_ACCESS_KEY']
    ENV['AWS_SECRET_ACCESS_KEY']
  else
    cred = File.open("#{ENV['HOME']}/.aws/credentials").read
    m = OnigRegexp.new('aws_secret_access_key\s?=\s?(.*)').match(cred)
    m[1]
  end
end

class Time
  # Hack mruby-aws-s3's Time#rfc2822
  # localtimeの場合時刻がずれてしまうので強制的にUTCにする
  def rfc2822
    utcdate = getutc
    sprintf('%s, %02d %s %0*d %02d:%02d:%02d ',
      RFC2822_DAY_NAME[utcdate.wday],
      utcdate.day, RFC2822_MONTH_NAME[utcdate.mon-1], utcdate.year < 0 ? 5 : 4, utcdate.year,
      utcdate.hour, utcdate.min, utcdate.sec) +
    if utcdate.utc?
      '-0000'
    else
      off = utc_offset
      sign = off < 0 ? '-' : '+'
      sprintf('%s%02d%02d', sign, (off.abs / 60) / 60, (off.abs / 60) % 60)
    end
  end
end

