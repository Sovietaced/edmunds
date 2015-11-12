require './test/test_helper'

class DecodingVinTest < Minitest::Test

  def test_full
    VCR.use_cassette('decode_full') do
      full = Edmunds::Vehicle::Specification::VinDecoding::Full.find('JHMAP11461T005905')
      assert_equal Edmunds::Vehicle::Specification::VinDecoding::Full, full.class

      # Check that the fields are accessible by our model
      assert_equal 'Honda', full.make.name
      assert_equal 'S2000', full.model.name
      assert_equal 1, full.years.count
      assert_equal 2001, full.years[0].year
      assert_equal '18', full.mpg_city
      assert_equal '24', full.mpg_highway
    end
  end

  def test_full_invalid_vin
    VCR.use_cassette('decode_full_invalid_vin') do
      exception = assert_raises Edmunds::Api::Exception do
        Edmunds::Vehicle::Specification::VinDecoding::Full.find('invalid')
      end

      assert_match "The VIN is incorrect. It must be 17 characters", exception.message
      assert_match "INCORRECT_PARAMS", exception.error_type
    end
  end

  def test_full_not_found
    VCR.use_cassette('decode_full_not_found') do
      exception = assert_raises Edmunds::Api::Exception do
        Edmunds::Vehicle::Specification::VinDecoding::Full.find('JHMAP00000T000000')
      end

      assert_match "Information not found for this VIN.", exception.message
      assert_match "RESOURCE_NOT_FOUND", exception.error_type
    end
  end
end
