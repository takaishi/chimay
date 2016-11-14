Chimay
====

MRuby script runner that get S3, http(s), or file with consul event.
Chimay had an influence from stretcher.

## Usage

```ruby
Chimay::Base.define do
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

Aws access key and aws secret access key are read from ~/.aws/credentials. If environment AWS\_ACCESS\_KEY or AWS\_SECRET\_ACCESS\_KEY exist, use it instead of credentials.

```
$ consul event -name run_script s3://example.com/script.rb
Chimay is peres trappistes!
```

## Install

## Contribution

## Licence

[MIT](https://github.com/takaishi/tool/blob/master/LICENCE)

## Author

[takaishi](https://github.com/takaishi)

