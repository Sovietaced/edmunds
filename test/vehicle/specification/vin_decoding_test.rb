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

  def test_full
    VCR.use_cassette('decode_full') do
      full = Edmunds::Vehicle::Specification::VinDecoding::Full.find("JHMAP11461T005905")
      assert_equal Edmunds::Vehicle::Specification::VinDecoding::Full, full.class

      # Check that the fields are accessible by our model
      assert_equal "Honda", full.make
      assert_equal "S2000", full.model
      assert_equal 2001, full.year
      assert_equal "18", full.mpg_city
      assert_equal "24", full.mpg_highway
      assert_equal "Convertible", full.body
    end
  end
end