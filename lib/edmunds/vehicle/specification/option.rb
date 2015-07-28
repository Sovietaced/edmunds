require 'faraday'
require 'json'

STYLE_API_URL = Edmunds::Vehicle::API_URL_V2 + '/styles'
OPTIONS_API_URL = Edmunds::Vehicle::API_URL_V2 + '/options'

module Edmunds
  module Vehicle
    module Specification
      module Option
        
        class OptionsByStyle
          attr_reader :interior, :exterior, :roof, :interior_trim, :mechanical, :package, :additional_fees, :other

          def initialize(attributes)
            @interior, @exterior, @roof, @interior_trim = [], [], [], []
            @mechanical, @package, @aditional_fees, @other = [], [], [], []

            attributes['options'].each do |category_with_option|
              category = category_with_option['category']
              options = category_with_option['options']
              if    category == "Interior"        then @interior        = options.map { |json| Option.new(json) } 
              elsif category == "Exterior"        then @exterior        = options.map { |json| Option.new(json) } 
              elsif category == "Roof"            then @roof            = options.map { |json| Option.new(json) } 
              elsif category == "Interior Trim"   then @interior_trim   = options.map { |json| Option.new(json) } 
              elsif category == "Mechanical"      then @mechanical      = options.map { |json| Option.new(json) } 
              elsif category == "Package"         then @package         = options.map { |json| Option.new(json) } 
              elsif category == "Additional Fees" then @additional_fees = options.map { |json| Option.new(json) } 
              elsif category == "Other"           then @other           = options.map { |json| Option.new(json) } 
              end
            end
            # @options = attributes['options'].map { |json| Option.new(json) } if attributes.key?('options')
            # @count = attributes['optionsCount']
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
            @equipment = attributes['equipment']
            @category = attributes['category']
            @attributes = attributes['attributes']
            @price = attributes['price']
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
