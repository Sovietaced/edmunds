require './test/test_helper'

class ModelTest < Minitest::Test
  def test_exists
    assert Edmunds::Vehicle::Specification::Model::Model
  end

  def test_model
    VCR.use_cassette('model') do
      model = Edmunds::Vehicle::Specification::Model::Model.find('honda', 'accord')
      assert_equal Edmunds::Vehicle::Specification::Model::Model, model.class

      # Check that the fields are accessible by our model
      assert_equal 'Honda_Accord', model.id
      assert_equal 'Accord', model.name
      assert_equal 26, model.years.count
    end
  end

  def test_models
    VCR.use_cassette('models') do
      models = Edmunds::Vehicle::Specification::Model::Models.find('honda')
      assert_equal Edmunds::Vehicle::Specification::Model::Models, models.class

      # Check that the fields are accessible by our model
      assert_equal 21, models.count
      assert_equal 21, models.models.count
    end
  end

  def test_models_count
    VCR.use_cassette('models_count') do
      models_count = Edmunds::Vehicle::Specification::Model::ModelsCount.find('honda')
      assert_equal Edmunds::Vehicle::Specification::Model::ModelsCount, models_count.class

      # Check that the fields are accessible by our model
      assert_equal 21, models_count.count
    end
  end
end
