require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
BASE_API_URL = Edmunds::Vehicle::API_URL_V2

module Edmunds
  module Vehicle
    module Specification
      module Style
        class Style
          attr_reader :id, :name, :trim, :body, :year, :make_name, :model_name, :engine, :transmission, :driven_wheels, :colors, :options

          def initialize(attributes, view = nil)
            @id = attributes['id']
            @name = attributes['name']
            @trim = attributes['trim']
            @body = attributes['submodel']['body']

            if view == 'full'
              @engine         = Edmunds::Vehicle::Specification::Engine::Engine.new(attributes['engine'])
              @transmission   = Edmunds::Vehicle::Specification::Transmission::Transmission.new(attributes['transmission'])
              @driven_wheels  = Edmunds::Vehicle::Specification::Drivetrain::Drivetrain.new(attributes['drivenWheels'])
              @colors         = Edmunds::Vehicle::Specification::Color::ColorsByStyle.new(attributes)
              @options        = Edmunds::Vehicle::Specification::Option::OptionsByStyle.new(attributes)
            end
            # TODO: Not sure whether this is valuable or not to expose...
            # @year = attributes["year"]["year"]
            # @make_name = attributes["make"]["name"]
            # @model_name = attributes["model"]["name"]
          end

          def self.find(id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{id}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                view: %w[basic full],
                fmt:  %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes, api_params[:view])
          end
        end

        class StylesDetails
          attr_reader :styles, :count

          def initialize(attributes)
            @count = attributes['stylesCount']
            @styles = attributes['styles'].map { |json| Style.new(json) } if attributes.key?('styles')
          end

          def self.find(make_name, model_name, model_year, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/#{model_year}/styles") do |request|
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

        # TODO
        # UNAUTHORIZED
        # class StylesDetailsChrome
        #   attr_reader :styles, :count

        #   def initialize(attributes)
        #     @count = attributes["stylesCount"]
        #     @styles = attributes["styles"].map {|json| Style.new(json)} if attributes.key?("styles")
        #   end

        #   def self.find(chrome_id, api_params = {})
        #     response = Edmunds::Api.get("#{BASE_API_URL}/partners/chrome/styles/#{chrome_id}", api_params)
        #     attributes = JSON.parse(response.body)
        #     new(attributes)
        #   end
        # end

        class StylesCountMakeModelYear
          attr_reader :count

          def initialize(attributes)
            @count = attributes['stylesCount']
          end

          def self.find(make_name, model_name, model_year, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/#{model_year}/styles/count") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                state: %w[new used future],
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCountMakeModel
          attr_reader :count

          def initialize(attributes)
            @count = attributes['stylesCount']
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/#{model_name}/styles/count") do |request|

              request.raw_parameters = api_params

              request.allowed_parameters = {
                state: %w[new used future],
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCountMake
          attr_reader :count

          def initialize(attributes)
            @count = attributes['stylesCount']
          end

          def self.find(make_name, api_params = {})
            response = Edmunds::Api.get("#{BASE_API_URL}/#{make_name}/styles/count") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                state: %w[new used future],
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class StylesCount
          attr_reader :count

          def initialize(attributes)
            @count = attributes['stylesCount']
          end

          def self.find(api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/count") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                state: %w[new used future],
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json' }

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
