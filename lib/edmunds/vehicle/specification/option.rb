require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
OPTIONS_API_URL = Edmunds::Vehicle::API_URL_V2 + '/options'

module Edmunds
  module Vehicle
    module Specification
      module Option
        
        class OptionsByStyle
          attr_reader :options, :count

          def initialize(attributes)
            @options = attributes['options'].map { |json| Option.new(json) } if attributes.key?('options')
            @count = attributes['optionsCount']
          end

          def self.find(style_id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{style_id}/options", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Option
          attr_reader :id, 
                      :name,
                      :description,
                      :equipment_type, 
                      :availability 
                      #TODO: The rest with pricing

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @description = attributes['description']
            @equipment_type = attributes['equipmentType']
            @availability = attributes['availability']
          end

          def self.find(option_id, api_params = {})
            response = Edmunds::Api.get("#{OPTIONS_API_URL}/#{option_id}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

      end
    end
  end
end
