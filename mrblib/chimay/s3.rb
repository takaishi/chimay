class S3
  class << self
    def run(uri)
      query = {}
      parser = HTTP::Parser.new
      parsed = parser.parse_url(uri)
      parsed.query.split('&').each do |q|
        a = q.split('=')
        query[a[0].to_sym] = a[1]
      end

      m = OnigRegexp.new("s3://([^/]+[-a-zA-Z0-9]+)(/[^/]+[-a-zA-Z0-9./]+)").match(uri)

      AWSAccessKeyId = aws_access_key_id
      AWSSecretAccessKey = aws_secret_access_key
      AWSBucket = m[1]

      aws = AWS::S3.new(AWSAccessKeyId, AWSSecretAccessKey)
      aws.set_bucket(AWSBucket)
      resp = aws.download(m[2])
      if resp.code.to_i == 200
        define = eval resp.body
        define._run(query)
      else
        puts "Error code = #{resp.code}"
        puts "Error body = #{resp.body}"
      end
    end 
    
    private

    def aws_access_key_id
      return ENV['AWS_ACCESS_KEY_ID'] if ENV['AWS_ACCESS_KEY_ID']

      read_credential('aws_access_key_id')
    end
    
    def aws_secret_access_key
      return ENV['AWS_SECRET_ACCESS_KEY'] if ENV['AWS_SECRET_ACCESS_KEY']

      read_credential('aws_secret_access_key')
    end

    def read_credential(key)
      cred = File.open("#{ENV['HOME']}/.aws/credentials").read
      m = OnigRegexp.new("#{key}\s?=\s?(.*)").match(cred)
      m[1]
    end
  end
end
