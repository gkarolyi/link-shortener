require "test_helper"

class ShortConverterTest < ActiveSupport::TestCase
  test "should encode IDs correctly" do
    assert_equal('qi', ShortConverter::Encoder.call(1000))
    assert_equal('ym', ShortConverter::Encoder.call(1500))
    assert_equal('czlo', ShortConverter::Encoder.call(573_452))
  end

  test "should decode shorts correctly" do
    assert_equal(4_507_169, ShortConverter::Decoder.call('as4Gr'))
    assert_equal(65_266, ShortConverter::Decoder.call('q8Q'))
    assert_equal(1_441_111_724_237, ShortConverter::Decoder.call('zxcv5TR'))
  end
end
