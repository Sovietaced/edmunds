require 'faraday'
require 'json'

MODEL_API_URL = Edmunds::Vehicle::API_URL_V2

module Edmunds
  module Vehicle
    module Specification
      module Model
        class Model
          attr_reader :id, :name, :nice_name, :years

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @nice_name = attributes['niceName']
            @years = attributes['years'].map { |json| Edmunds::Vehicle::Specification::ModelYear::ModelYear.new(json) } if attributes.key?('years')
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/#{model_name}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                submodel: Edmunds::Vehicle::SUBMODEL_REGEX,
                category: Edmunds::Vehicle::VEHICLE_CATEGORIES,
                state: %w[new used future],
                year: ((1990.to_s)..(Date.current.year.to_s)),
                view: %w[basic full],
                fmt:  %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Models
          attr_reader :models, :count

          def initialize(attributes)
            @count = attributes['modelsCount']
            @models = attributes['models'].map { |json| Model.new(json) } if attributes.key?('models')
          end

          def self.find(make_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/models") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                submodel: Edmunds::Vehicle::SUBMODEL_REGEX,
                category: Edmunds::Vehicle::VEHICLE_CATEGORIES,
                state: %w[new used future],
                year: ((1990.to_s)..(Date.current.year.to_s)),
                view: %w[basic full],
                fmt:  %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class ModelsCount
          attr_reader :count

          def initialize(attributes)
            @count = attributes['modelsCount']
          end

          def self.find(make_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/models/count") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                submodel: Edmunds::Vehicle::SUBMODEL_REGEX,
                category: Edmunds::Vehicle::VEHICLE_CATEGORIES,
                state: %w[new used future],
                year: ((1990.to_s)..(Date.current.year.to_s)),
                view: %w[basic full],
                fmt:  %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end
      end
    end
  end
end
