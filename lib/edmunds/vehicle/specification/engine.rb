require 'faraday'
require 'json'

ENGINE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/engines'
STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'

module Edmunds
  module Vehicle
    module Specification
      module Engine
        
        class EngineByStyle
          attr_reader :id

          def initialize(attributes)
            @id = attributes['id']
            #TODO
          end

          def self.find(style_id, api_params = {})
            response = Edmunds::Api.get("#{STYLE_API_URL}/#{style_id}/engines") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                availability: Edmunds::Vehicle::ENGINE_AVAILABILITY, 
                name: /^s+/,
                fmt:  %w[json]
              }

              request.default_parameters = { fmt: 'json', availability: 'standard' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Engine
          attr_reader :code, :compression_ratio, :compressor_type, :configuration, :cylinder, :displacement, :equipment_type, :fuel_type,
            :horsepower, :id, :manufacturer_engine_code, :name, :rpm, :size, :torque, :total_valves, :type, :valve

          def initialize(attributes)
            @code = attributes['code']
            @compression_ratio = attributes['compressionRatio']
            @compressor_type = attributes['compressorType']
            @configuration = attributes['configuration']
            @cylinder = attributes['cylinder']
            @displacement = attributes['displacement']
            @equipment_type = attributes['equipmentType']
            @fuel_type = attributes['fuelType']
            @horsepower = attributes['horsepower']
            @id = attributes['id']
            @manufacturer_engine_code = attributes['manufacturerEngineCode']
            @name = attributes['name']
            @rpm = attributes['rpm']
            @size = attributes['size']
            @torque = attributes['torque']
            @total_valves = attributes['totalValves']
            @type = attributes['type']
            @valve = attributes['valve']
          end

          def self.find(engine_id, api_params = {})
            response = Edmunds::Api.get("#{ENGINE_API_URL}/#{engine_id}") do |request|
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
