require 'edmunds'

module Edmunds
  module Vehicle
    # Static Vehicle API data
    API_URL_V1 = Edmunds::Api::URL_V1 + '/vehicle'
    API_URL_V2 = Edmunds::Api::URL + '/vehicle/v2'
    VEHICLE_TYPES      = %w[ Car Truck SUV Van Minivan ]
    VEHICLE_CATEGORIES = %w[ 4dr\ Hatchback 2dr\ Hatchback 2dr\ SUV 4dr\ SUV
                            Cargo\ Minivan Cargo\ Van Convertible Convertible\ SUV
                            Coupe Crew\ Cab\ Pickup Extended\ Cab\ Pickup Passenger\ Minivan
                            Passenger\ Van Regular\ Cab\ Pickup Sedan Wagon ]
    VEHICLE_SIZES      = %w[ Compact Midsize Large ]
    FUEL_TYPES         = %w[ Electric Natural-gas-cng gas hybrid Flex-fuel-ffv diesel]
    DRIVEN_WHEELS      = %w[ all-wheel-drive four-wheel-drive front-wheel-drive rear-wheel-drive ]

                          #http://rubular.com/r/QODEdKNxjB
    SUBMODEL_REGEX     = /^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$/
    EQUIPMENT_AVAILABILITY = %w[ standard optional used]
    EQUIPMENT_TYPE = %w[ AUDIO_SYSTEM COLOR ENGINE MANUFACTURER MIRRORS OPTION OTHER TELEMATICS TIRES]
    EQUIPMENT_NAME = %w[ 1ST_ROW_SEATS 2ND_ROW_SEATS 3RD_ROW_SEATS 4TH_ROW_SEATS 5TH_ROW_SEATS AIR_CONDITIONING
                        AIRBAGS AUDIO_SYSTEM BRAKE_SYSTEM CARGO_DIMENSIONS COLLISION_SAFETY_SYSTEM COLOR 
                        CONVERTIBLE_ROOF DIFFERENTIAL DOORS DRIVE_TYPE DRIVER_SEAT ENGINE EXTERIOR_DIMENSIONS 
                        EXTERIOR_LIGHTS FRONT_PASSENGER_SEAT INSTRUMENTATION INTERIOR_DIMENSIONS MANUFACTURER 
                        MIRRORS MOBILE_CONNECTIVITY NAVIGATION_SYSTEM PARKING_AID POWER_OUTLETS SEATBELTS
                        SEATING_CONFIGURATION SECURITY SPARE_TIRE/WHEEL SPECIFICATIONS STEERING STEERING_WHEEL 
                        STORAGE SUSPENSION TECHNOLOGY_FEATURE TELEMATICS TIRES TRAILER_TOWING_EQUIPMENT 
                        TRANSMISSION TRUCK_BED TRUNK VIDEO_SYSTEM WARRANTY WHEELS WINDOWS]
  end
end
