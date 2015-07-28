module Edmunds
  module Vehicle
    module Specification
      module Transmission
        class Transmission
          attr_reader :id, :name, :equipment_type, :availability, :automatic_type, :transmission_type, :number_of_speeds

          def initialize(attributes)
            @id = attributes['id']
            @name = attributes['name']
            @equipment_type = attributes['equipmentType']
            @availability = attributes['availability']
            @automatic_type = attributes['automaticType']
            @transmission_type = attributes['transmissionType']
            @number_of_speeds = attributes['numberOfSpeeds']
          end
        end
      end
    end
  end
end
