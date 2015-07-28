module Edmunds
  module Vehicle
    module Specification
      module Drivetrain
        class Drivetrain

          def initialize(name)
            @name = name
          end

          def name(view = :long)
            if view == :short
              case @name
              when "front wheel drive"  then "FWD"
              when "rear wheel drive"   then "RWD"
              when "all wheel drive"    then "AWD"
              when "four wheel drive"   then "4WD"
              end
            else
              @name
            end
          end
        end
      end
    end
  end
end