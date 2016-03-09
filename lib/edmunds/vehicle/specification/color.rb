require 'faraday'
require 'json'

module Edmunds
  module Vehicle
    module Specification
      module Color

        STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
        COLORS_API_URL = Edmunds::Vehicle::API_URL_V2 + '/colors'
        
        class ColorsByStyle
          attr_reader :colors, :count

          def initialize(attributes)
            @colors = attributes['colors'].map { |json| ColorsDetails.new(json) } if attributes.key?('colors')
            @count = attributes['colorsCount']
          end

          def self.find(style_id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{style_id}/colors") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  category: %w[Interior Exterior],
                  fmt: %w[json]
              }

              request.default_parameters = { fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class ColorsDetails
          attr_reader :id, 
                      :name, 
                      :equipment_type, 
                      :availability, 
                      :manufacture_option_name, 
                      :manufacture_option_code, 
                      :category, 
                      :attributes, #not implemented
                      :color_chips, #not_implemented
                      :fabric_Types #not implemented

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @equipment_type = attributes['equipmentType']
            @availability = attributes['availability']
            @manufacture_option_name = attributes['manufactureOptionName']
            @manufacture_option_code = attributes['manufactureOptionCode']
            @category = attributes['category']
          end

          def self.find(color_id, api_params = {})
            response = Edmunds::Api.get("#{COLORS_API_URL}/#{color_id}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  fmt: %w[json]
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
