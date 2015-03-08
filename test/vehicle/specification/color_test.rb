require './test/test_helper'

class ColorTest < Minitest::Test
  def test_colors_by_style
    VCR.use_cassette('colors_by_style') do
      colors_by_style = Edmunds::Vehicle::Specification::Color::ColorsByStyle.find(200477465)
      assert_equal Edmunds::Vehicle::Specification::Color::ColorsByStyle, colors_by_style.class

      # Check that the fields are accessible by our model
      assert_equal 19, colors_by_style.colors.count
      assert_equal 19, colors_by_style.count
    end
  end

  def test_colors_details
    VCR.use_cassette('colors_details') do
      colors_details = Edmunds::Vehicle::Specification::Color::ColorsDetails.find(200477485)
      assert_equal Edmunds::Vehicle::Specification::Color::ColorsDetails, colors_details.class

      # Check that the fields are accessible by our model
      assert_equal '200477485', colors_details.id
      assert_equal 'Ibis White', colors_details.name
      assert_equal 'COLOR', colors_details.equipment_type
      assert_equal 'USED', colors_details.availability
      assert_equal 'Ibis White', colors_details.manufacture_option_name
      assert_equal 'T9T9', colors_details.manufacture_option_code
      assert_equal 'Exterior', colors_details.category
    end
  end

end
