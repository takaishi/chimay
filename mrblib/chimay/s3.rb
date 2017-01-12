module Chimay
  class S3 < Chimay::Base
    def run
      eval_script(script)
    end
    
    private

    def script
      m = OnigRegexp.new("s3://([^/]+[-a-zA-Z0-9]+)(/[^/]+[-a-zA-Z0-9./]+)").match(@uri)

      bucket = m[1]

      aws = AWS::S3.new(aws_access_key_id, aws_secret_access_key)
      aws.set_bucket(bucket)
      resp = aws.download(m[2])
      if resp.code.to_i == 200
        resp.body
      else
        raise "Failed to download script, code = #{resp.code}, body = #{resp.body}"
      end
    end

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
