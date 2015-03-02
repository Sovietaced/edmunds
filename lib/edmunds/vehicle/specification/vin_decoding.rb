require 'faraday'
require 'json'

API_URL = Edmunds::Vehicle::API_URL_V1 + "/vin/"

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

          def self.find(vin)
            response = Faraday.get("#{API_URL}/#{vin}/configuration", { api_key: ENV['EDMUNDS_API_KEY'] })
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end
      end
    end
  end
end
