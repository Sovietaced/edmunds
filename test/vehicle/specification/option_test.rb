require './test/test_helper'

class OptionTest < Minitest::Test
  def test_options_by_style
    VCR.use_cassette('options_by_style') do
      options_by_style = Edmunds::Vehicle::Specification::Option::OptionsByStyle.find(200477465)
      assert_equal Edmunds::Vehicle::Specification::Option::OptionsByStyle, options_by_style.class

      # Check that the fields are accessible by our model
      assert_equal 20, options_by_style.options.count
      assert_equal 20, options_by_style.count
    end
  end

  def test_option
    VCR.use_cassette('option') do
      option = Edmunds::Vehicle::Specification::Option::Option.find(200477503)
      assert_equal Edmunds::Vehicle::Specification::Option::Option, option.class

      # Check that the fields are accessible by our model
      assert_equal '200477503', option.id
      assert_equal 'Premium Plus ', option.name
      assert_equal "18\" 5-spoke-design wheels with 245/45R18 all-season tires; 7\" color Driver Information System; MMI Navigation plus; Audi Connect with 6-month complimentary trial period data contract includes voice-activated Google Earth navigation, Google Local search, Real time Sirius traffic with 3-month complimentary subscription, myAudi destinations and rolling wi-fi hotspot; Power, heated, auto-dimming, manual folding exterior mirrors with memory; HD radio; MMI touch and Jukebox; Audi parking system plus with rearview camera; Audi advance key; Xenon plus headlights with LED daytime running lights", option.description
      assert_equal 'OPTION', option.equipment_type
      assert_equal '2.0T quattro', option.availability
    end
  end

end
