require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + "/styles"

module Edmunds
  module Vehicle
    module Specification
      module Style

        class Style
          attr_reader :id, :name, :trim, :body, :year, :make_name, :model_name

          def initialize(attributes)
            @id = attributes["id"]
            @name = attributes["name"]
            @trim = attributes["trim"]
            @body = attributes["submodel"]["body"]
            # TODO: Not sure whether this is valuable or not to expose...
            # @year = attributes["year"]["year"]
            # @make_name = attributes["make"]["name"]
            # @model_name = attributes["model"]["name"]
          end

          def self.find(id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{id}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

      end
    end
  end
end
