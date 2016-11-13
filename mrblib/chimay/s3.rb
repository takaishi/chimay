class S3
  class << self
    def run(uri)
      m = OnigRegexp.new("s3://([^/]+[-a-zA-Z0-9]+)(/[^/]+[-a-zA-Z0-9./]+)").match(uri)

      AWSAccessKeyId = aws_access_key_id
      AWSSecretAccessKey = aws_secret_access_key
      AWSBucket = m[1]

      aws = AWS::S3.new(AWSAccessKeyId, AWSSecretAccessKey)
      aws.set_bucket(AWSBucket)
      resp = aws.download(m[2])
      if resp.code.to_i == 200
        define = eval resp.body
        define.run
      else
        puts "Error code = #{resp.code}"
        puts "Error body = #{resp.body}"
      end
    else
      file = File.open(argv[1])
      eval(file.read, nil, __FILE__, __LINE__)
    end 
    
    private

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
  end
end