require 'faraday'
require 'json'

BASIC_API_URL = Edmunds::Vehicle::API_URL_V1 + "/vin"
FULL_API_URL = Edmunds::Vehicle::API_URL_V2 + "/vins"

module Edmunds
  module Vehicle
    module Specification
      module VinDecoding

        class Basic
          attr_reader :make, :model, :year

          def initialize(attributes)
            @make = attributes["make"]["name"]
            @model = attributes["model"]["name"]
            @year = attributes["year"]
          end

          # Get vehicle make, model, year, type, fuel type, number of cylinders and list of styles by decoding the vehicle's VIN.
          #
          # @param [String] vin number of the vehicle to search for
          # @return [Basic] object holding the results of the query
          def self.find(vin)
            response = Edmunds::Api.get("#{BASIC_API_URL}/#{vin}/configuration")
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Full
          attr_reader :make, :model, :year, :mpg_highway, :mpg_city, :body

          def initialize(attributes)
            @make = attributes["make"]["name"]
            @model = attributes["model"]["name"]
            @year = attributes["years"][0]["year"]
            @mpg_highway = attributes["MPG"]["highway"]
            @mpg_city = attributes["MPG"]["city"]
            @body = attributes["years"][0]["styles"][0]["submodel"]["body"]
          end

          # Get all vehicle details from make, model, year and fuel type to list of options, features and standard equipment. All this information is returned by decoding the vehicle's VIN.
          #
          # @param [String] vin number of the vehicle to search for
          # @return [Basic] object holding the results of the query
          def self.find(vin)
            response = Edmunds::Api.get("#{FULL_API_URL}/#{vin}")
            puts response.body
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

      end
    end
  end
end
