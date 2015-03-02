require './test/test_helper'

class MakeTest < Minitest::Test
  def test_exists
    assert Edmunds::Vehicle::Specification::Make::Make
  end

  def test_make
    VCR.use_cassette('make') do
      make = Edmunds::Vehicle::Specification::Make::Make.find("audi")
      assert_equal Edmunds::Vehicle::Specification::Make::Make, make.class

      # Check that the fields are accessible by our model
      assert_equal 200000001, make.id
      assert_equal "Audi", make.name
      assert_equal 35, make.models.count
    end
  end

  def test_makes
    VCR.use_cassette('makes') do
      makes = Edmunds::Vehicle::Specification::Make::Makes.find()
      assert_equal Edmunds::Vehicle::Specification::Make::Makes, makes.class


      # Check that the fields are accessible by our model
      assert_equal 61, makes.makes.count
    end
  end
end