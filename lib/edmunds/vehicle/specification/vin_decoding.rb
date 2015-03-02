require 'faraday'
require 'json'

API_URL = "https://api.edmunds.com/api/v1/vehicle/vin/"

module Edmunds
  module Vehicle
    module Specification
      module VinDecoding
        class Basic
          attr_reader :make, :model, :year

          def initialize(attributes)
            @make = attributes["make"]
            @model = attributes["model"]
            @year = attributes["year"]
          end

          def self.find(vin)
            response = Faraday.get("#{API_URL}/#{vin}/configuration")
            attributes = JSON.parse(response.body)
            puts response.body
            new(attributes)
          end
        end
      end
    end
  end
end
