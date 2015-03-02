require 'faraday'
require 'json'

ALL_API_URL = Edmunds::Vehicle::API_URL_V2 + "/makes"
MAKE_API_URL = Edmunds::Vehicle::API_URL_V2

module Edmunds
  module Vehicle
    module Specification
      module Make

        class Make
          attr_reader :name, :models

          def initialize(attributes)
            @name = attributes["name"]
          end

          def self.find(name, api_params = {})
            response = Edmunds::Api.get("#{MAKE_API_URL}/#{name}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

      end
    end
  end
end
