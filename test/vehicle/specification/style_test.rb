require './test/test_helper'

class StyleTest < Minitest::Test
  def test_exists
    assert Edmunds::Vehicle::Specification::Style::Style
  end

  def test_model_year
    VCR.use_cassette('style') do
      style = Edmunds::Vehicle::Specification::Style::Style.find(200487199)
      assert_equal Edmunds::Vehicle::Specification::Style::Style, style.class

      # Check that the fields are accessible by our model
      assert_equal 200487199, style.id
      assert_equal "EX-L V6 w/Navigation 4dr Sedan (3.5L 6cyl 6A)", style.name
      assert_equal "EX-L V-6 w/Navigation", style.trim
      assert_equal "Sedan", style.body
      # assert_equal 2014, style.year
      # assert_equal "Honda", style.make_name
      # assert_equal "Accord", style.model_name
    end
  end
end