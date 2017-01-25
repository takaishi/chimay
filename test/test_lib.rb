class TestLib < MTest::Unit::TestCase
  def test_main
    assert_nil nil
  end

  def test_base64
    assert_equal(Chimay::Base64.encode('ruby'), 'cnVieQ==')
    assert_equal(Chimay::Base64.decode('cnVieQ=='), 'ruby')
  end
end

MTest::Unit.new.run
