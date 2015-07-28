require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
COLORS_API_URL = Edmunds::Vehicle::API_URL_V2 + '/colors'

module Edmunds
  module Vehicle
    module Specification
      module Color
        
        class ColorsByStyle
          attr_reader :exterior, :interior #, :colors, :count

          def initialize(attributes)
            # @colors = attributes['colors'].map { |json| ColorsDetails.new(json) } if attributes.key?('colors')
            # ['colors'] is actually a size 2 Array that contains interior colors in position 0 and exterior colors in position 1
            @interior, @exterior = [], []
            @interior = attributes['colors'][0]['options'].map { |json| InteriorColor.new(json) } if attributes['colors'][0].present?
            @exterior = attributes['colors'][1]['options'].map { |json| ExteriorColor.new(json) } if attributes['colors'][1].present?

            # @count = attributes['colorsCount'] # Could not find this key in response
          end

          def self.find(style_id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{style_id}/colors", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Color
          attr_reader :id, 
                      :name, 
                      :equipment_type, 
                      :availability, 
                      :manufacture_option_name, 
                      :manufacture_option_code,
                      :color_chips,
                      :attributes #not implemented

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @equipment_type = attributes['equipmentType']
            @availability = attributes['availability']
            @manufacture_option_name = attributes['manufactureOptionName']
            @manufacture_option_code = attributes['manufactureOptionCode']
            @color_chips = attributes['colorChips']
          end

          def self.find(color_id, api_params = {})
            response = Edmunds::Api.get("#{COLORS_API_URL}/#{color_id}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class InteriorColor < Color          
          attr_reader :fabric_types

          def initialize(attributes)
            super(attributes)
            @fabric_types = attributes['fabricTypes']
          end
        end

        class ExteriorColor < Color 
          def initialize(attributes)
            super(attributes)
          end
        end

      end
    end
  end
end
