Chimay
====

run mruby script via s3, consul kvs like stretcher.

## Description

## Demo

## VS. 

## Requirement

## Usage

```ruby
Chimay::Base.define do
  run do
    puts 'Chimay is peres trappistes!'
  end
end
```

### input from stdin

```
$ cat /path/to/script.rb | chimay
Chimay is peres trappistes!
```

### input from S3

Aws access key and aws secret access key are read from ~/.aws/credentials. If environment AWS\_ACCESS\_KEY or AWS\_SECRET\_ACCESS\_KEY exist, use it instead of credentials.

```
$ echo s3://example.com/script.rb | chimay
Chimay is peres trappistes!
```

### input from HTTP

```
$ echo http://example.com/script.rb | chimay
Chimay is peres trappistes!
```

## Install

## Contribution

## Licence

[MIT](https://github.com/takaishi/tool/blob/master/LICENCE)

## Author

[takaishi](https://github.com/takaishi)

