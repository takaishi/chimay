Chimay
====

This is mruby script runner that get script from S3, http(s), or file with consul event.
Chimay had an influence from stretcher.

## Usage

```ruby
Chimay::Script.define do
  run do
    puts 'Chimay is peres trappistes!'
  end
end
```

### command

```
$ echo s3://example.com/script.rb | chimay
Chimay is peres trappistes!
```

### consul

Aws access key and aws secret access key are read from ~/.aws/credentials. If environment AWS\_ACCESS\_KEY\_ID or AWS\_SECRET\_ACCESS\_KEY exist, use it instead of credentials.

```
$ consul event -name run_script s3://example.com/script.rb
Chimay is peres trappistes!
```

## Licence

[MIT](https://github.com/takaishi/tool/blob/master/LICENCE)

## Author

[r_takaishi](https://github.com/takaishi)

