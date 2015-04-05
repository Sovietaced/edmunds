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
  end
end
