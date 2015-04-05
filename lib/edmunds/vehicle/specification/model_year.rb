require 'faraday'
require 'json'

MODEL_YEAR_API_URL = Edmunds::Vehicle::API_URL_V2

module Edmunds
  module Vehicle
    module Specification
      module ModelYear
        class ModelYear
          attr_reader :id, :year, :styles

          def initialize(attributes)
            @id = attributes['id']
            @year = attributes['year']
            @styles = attributes['styles'].map { |json| Edmunds::Vehicle::Specification::Style::Style.new(json) } if attributes.key?('styles')
          end

          def self.find(make_name, model_name, model_year, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/#{model_name}/#{model_year}") do |request|
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

        class ModelYears
          attr_reader :model_years, :count

          def initialize(attributes)
            @count = attributes['yearsCount']
            @model_years = attributes['years'].map { |json| ModelYear.new(json) } if attributes.key?('years')
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/#{model_name}/years") do |request|
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

        class ModelYearsCount
          attr_reader :count

          def initialize(attributes)
            @count = attributes['yearsCount']
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/#{model_name}/years/count") do |request|
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
