require './test/test_helper'

class DecodingVinTest < Minitest::Test
  def test_exists
    assert Edmunds::Vehicle::Specification::VinDecoding::Basic
  end

  def test_basic
    VCR.use_cassette('decode_basic') do
      basic = Edmunds::Vehicle::Specification::VinDecoding::Basic.find("JHMAP11461T005905")
      assert_equal Edmunds::Vehicle::Specification::VinDecoding::Basic, basic.class

      # Check that the fields are accessible by our model
      assert_equal "Honda", basic.make
      assert_equal "S2000", basic.model
      assert_equal 2001, basic.year
    end
  end
end