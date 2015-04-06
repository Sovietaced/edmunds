require 'faraday'
require 'json'

EQUIPMENT_API_URL = Edmunds::Vehicle::API_URL_V2 + '/equipment'
STYLES_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'

module Edmunds
  module Vehicle
    module Specification
      module Equipment
        
        class EquipmentByStyle
          attr_reader :id

          def initialize(attributes)
            @id = attributes['id']
            #TODO
          end

          def self.find(styles_id, api_params = {})
            response = Edmunds::Api.get("#{STYLES_API_URL}/#{styles_id}/equipment") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                availability: Edmunds::Vehicle::EQUIPMENT_AVAILABILITY, 
                equipmentType: Edmunds::Vehicle::EQUIPMENT_TYPE,
                name: Edmunds::Vehicle::EQUIPMENT_NAME,
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json', availability: 'standard', equipmentType: 'OTHER' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Equipment
          attr_reader :id

          def initialize(attributes)
            @id = attributes['id']
            #TODO
          end

          def self.find(equipment_id, api_params = {})
            response = Edmunds::Api.get("#{EQUIPMENT_API_URL}/#{equipment_id}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
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
