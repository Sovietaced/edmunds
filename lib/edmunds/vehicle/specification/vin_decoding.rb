require 'faraday'
require 'json'

BASIC_API_URL = Edmunds::Vehicle::API_URL_V1 + '/vin'
FULL_API_URL = Edmunds::Vehicle::API_URL_V2 + '/vins'

module Edmunds
  module Vehicle
    module Specification
      module VinDecoding
        class Basic
          attr_reader :make, :model, :year

          def initialize(attributes)
            @make = attributes['make']['name']
            @model = attributes['model']['name']
            @year = attributes['year']
          end

          # Get vehicle make, model, year, type, fuel type, number of cylinders and list of styles by decoding the vehicle's VIN.
          #
          # @param [String] vin number of the vehicle to search for
          # @return [Basic] object holding the results of the query
          def self.find(vin, api_params = {})
            response = Edmunds::Api.get("#{BASIC_API_URL}/#{vin}/configuration") do |request|
              request.raw_parameters = api_params
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Full
          attr_reader :make, :model, :years, :trim, :description, :transmission, :engine, :mpg_highway, :mpg_city

          def initialize(attributes)
            @make = Edmunds::Vehicle::Specification::Make::Make.new(attributes['make'])
            @model = Edmunds::Vehicle::Specification::Model::Model.new(attributes['model'])
            @years = attributes['years'].map { |json| Edmunds::Vehicle::Specification::ModelYear::ModelYear.new(json) } if attributes.key?('years') 
            @mpg_highway = attributes['MPG']['highway']
            @mpg_city = attributes['MPG']['city']
          end

          # Get all vehicle details from make, model, year and fuel type to list of options, features and standard equipment. All this information is returned by decoding the vehicle's VIN.
          #
          # @param [String] vin number of the vehicle to search for
          # @return [Basic] object holding the results of the query
          def self.find(vin, api_params = {})
            response = Edmunds::Api.get("#{FULL_API_URL}/#{vin}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                # OEM CODE
                fmt:  %w[json]
              }

              request.default_parameters = {fmt: 'json' }

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
