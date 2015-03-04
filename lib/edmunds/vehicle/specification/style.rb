require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + "/styles"
BASE_API_URL = Edmunds::Vehicle::API_URL_V2

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

        class StylesDetails
          attr_reader :styles, :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
            @styles = attributes["styles"].map {|json| Style.new(json)} if attributes.key?("styles")
          end

          def self.find(make_name, model_name, model_year, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/#{model_year}/styles", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesDetailsChrome
          attr_reader :styles, :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
            @styles = attributes["styles"].map {|json| Style.new(json)} if attributes.key?("styles")
          end

          def self.find(chrome_id, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/partners/chrome/styles/#{chrome_id}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCountMakeModelYear
          attr_reader :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
          end

          def self.find(make_name, model_name, model_year, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/#{model_year}/styles/count", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCountMakeModel
          attr_reader :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/styles/count", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCountMake
          attr_reader :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
          end

          def self.find(make_name, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/styles/count", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCount
          attr_reader :count

          def initialize(attributes)
            @count = attributes["stylesCount"]
          end

          def self.find(api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/count", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

      end
    end
  end
end
