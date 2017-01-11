class TestCLI < MTest::Unit::TestCase
  def test_main
    assert_nil nil
  end

  def test_http?
    assert(chimay.http?('http://example.com/'))
    assert(chimay.http?('http://example.com/example.rb'))
  end

  def test_s3?
    assert(chimay.s3?('s3://rtakaishi-test/example.rb'))
  end

  def test_file?
    assert(chimay.file?('file://path/to/example.rb'))
  end

  def test_parse_stdin?
    payload = 's3://rtakaishi-test/example.rb'
    consl_event_test = <<EOS
[
    {
    "ID":"c07ab627-acf8-4ae3-8e7b-92dade545a46",
    "Name": "chimay",
    "Payload": "#{PolarSSL::Base64.encode(payload)}",
    "NodeFilter": "",
    "ServiceFilter": "",
    "TagFilter": "",
    "Version": 1,
    "LTime": 11
}
]
EOS

    assert_equal(chimay.parse_stdin(consl_event_test.gsub(' ', '').gsub("\n", '')), {:type => :s3, :payload => payload})
  end

  def chimay
    @chimay ||= Chimay::CLI.new
  end
end

MTest::Unit.new.run
