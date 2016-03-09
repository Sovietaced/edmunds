require 'faraday'
require 'json'

module Edmunds
  module Vehicle
    module Specification
      module Option
        
        STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
        OPTIONS_API_URL = Edmunds::Vehicle::API_URL_V2 + '/options'
        
        class OptionsByStyle
          attr_reader :options, 
                      :count

          def initialize(attributes)
            @options = attributes['options'].map { |json| Option.new(json) } if attributes.key?('options')
            @count = attributes['optionsCount']
          end

          def self.find(style_id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{style_id}/options") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  category: %w[Interior Exterior Roof Interior\ Trim Mechanical Package Additional\ Fees Other],
                  fmt: %w[json]
              }

              request.default_parameters = { fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Option
          attr_reader :id, 
                      :name,
                      :description,
                      :equipment_type, 
                      :availability,
                      :manufacture_option_name,
                      :manufacture_option_code,
                      :category, 
                      :attributes,
                      :equipment #not implemented
                      #TODO: The rest with pricing

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @description = attributes['description']
            @equipment_type = attributes['equipmentType']
            @availability = attributes['availability']
            @manufacture_option_name = attributes['manufactureOptionName']
            @manufacture_option_code = attributes['manufactureOptionCode']
            @category = attributes['category']
            @attributes = attributes['attributes']
            @equipment = attributes['equipment']
          end

          def self.find(option_id, api_params = {})
            response = Edmunds::Api.get("#{OPTIONS_API_URL}/#{option_id}") do |request|
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
