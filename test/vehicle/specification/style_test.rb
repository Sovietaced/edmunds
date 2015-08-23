require './test/test_helper'

class StyleTest < Minitest::Test
  def test_exists
    assert Edmunds::Vehicle::Specification::Style::Style
  end

  def test_style
    VCR.use_cassette('style') do
      style = Edmunds::Vehicle::Specification::Style::Style.find(200_487_199)
      assert_equal Edmunds::Vehicle::Specification::Style::Style, style.class

      # Check that the fields are accessible by our model
      assert_equal 200_487_199, style.id
      assert_equal 'EX-L V6 w/Navigation 4dr Sedan (3.5L 6cyl 6A)', style.name
      assert_equal 'EX-L V-6 w/Navigation', style.trim
      assert_equal 'Sedan', style.body
      # assert_equal 2014, style.year
      # assert_equal "Honda", style.make_name
      # assert_equal "Accord", style.model_name
    end
  end

  def test_styles_details
    VCR.use_cassette('style_details') do
      styles_details = Edmunds::Vehicle::Specification::Style::StylesDetails.find('honda', 'accord', 2013)
      assert_equal Edmunds::Vehicle::Specification::Style::StylesDetails, styles_details.class

      # Check that the fields are accessible by our model
      assert_equal 21, styles_details.count
      assert_equal 21, styles_details.styles.count
    end
  end

  # TODO: Unable to test because of public API KEY
  # def test_styles_details_chrome
  #   VCR.use_cassette('style_details_chrome') do
  #     styles_details_chrome = Edmunds::Vehicle::Specification::Style::StylesDetailsChrome.find(11916)
  #     assert_equal Edmunds::Vehicle::Specification::Style::StylesDetailsChrome, styles_details_chrome.class

  #     # Check that the fields are accessible by our model
  #     # assert_equal 21, styles_details_chrome.count
  #     # assert_equal 21, styles_details_chrome.styles.count
  #   end
  # end

  def test_styles_count_make_model_year
    VCR.use_cassette('style_count_make_model_year') do
      styles_count_make_model_year = Edmunds::Vehicle::Specification::Style::StylesCountMakeModelYear.find('honda', 'accord', 2013)
      assert_equal Edmunds::Vehicle::Specification::Style::StylesCountMakeModelYear, styles_count_make_model_year.class

      # Check that the fields are accessible by our model
      assert_equal 21, styles_count_make_model_year.count
    end
  end

  def test_styles_count_make_model
    VCR.use_cassette('style_count_make_model') do
      styles_count_make_model = Edmunds::Vehicle::Specification::Style::StylesCountMakeModel.find('honda', 'accord')
      assert_equal Edmunds::Vehicle::Specification::Style::StylesCountMakeModel, styles_count_make_model.class

      # Check that the fields are accessible by our model
      assert_equal 511, styles_count_make_model.count
    end
  end

  def test_styles_count_make
    VCR.use_cassette('style_count_make') do
      styles_count_make = Edmunds::Vehicle::Specification::Style::StylesCountMake.find('honda')
      assert_equal Edmunds::Vehicle::Specification::Style::StylesCountMake, styles_count_make.class

      # Check that the fields are accessible by our model
      assert_equal 1923, styles_count_make.count
    end
  end

  def test_styles_count
    VCR.use_cassette('style_count') do
      styles_count = Edmunds::Vehicle::Specification::Style::StylesCount.find
      assert_equal Edmunds::Vehicle::Specification::Style::StylesCount, styles_count.class

      # Check that the fields are accessible by our model
      assert_equal 46_398, styles_count.count
    end
  end
end
