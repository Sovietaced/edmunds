require 'faraday'
require 'json'

MAKE_API_URL = Edmunds::Vehicle::API_URL_V2
MAKES_API_URL = MAKE_API_URL + '/makes'
MAKES_COUNT_API_URL = MAKES_API_URL + '/count'

module Edmunds
  module Vehicle
    module Specification
      module Make
        class Makes
          attr_reader :makes

          def initialize(attributes)
            @makes = attributes['makes'].map { |json| Make.new(json) } if attributes.key?('makes')
          end

          def self.find(api_params = {})
            response = Edmunds::Api.get("#{MAKES_API_URL}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  state: %w[new used future],
                  year:  ((1990.to_s)..(Date.current.year.to_s)),
                  view:  %w[basic full],
                  fmt: %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class Make
          attr_reader :id, :name, :nice_name, :models

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @nice_name = attributes['niceName']
            @models = attributes['models'].map { |json| Edmunds::Vehicle::Specification::Model::Model.new(json) } if attributes.key?('models')
          end

          def self.find(name, api_params = {})
            response = Edmunds::Api.get("#{MAKE_API_URL}/#{name}") do |request|
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  state: %w[new used future],
                  year: ((1990.to_s)..(Date.today.year.to_s)),
                  view: %w[basic full],
                  fmt: %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

              request.required_parameters = %w[fmt]
            end

            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end

        class MakesCount
          attr_reader :count

          def initialize(attributes)
            @count = attributes['makesCount']
          end

          def self.find(api_params = {})
            response = Edmunds::Api.get("#{MAKES_COUNT_API_URL}") do |request|
            
              request.raw_parameters = api_params

              request.allowed_parameters = {
                  state: %w[new used future],
                  year: ((1990.to_s)..(Date.today.year.to_s)),
                  view: %w[basic full],
                  fmt: %w[json]
              }

              request.default_parameters = { view: 'basic', fmt: 'json' }

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
