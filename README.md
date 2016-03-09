# edmunds 
Edmunds.com Ruby API Wrapper 

[![Codeship Status for sovietaced/edmunds](https://codeship.io/projects/d03c61a0-a2bc-0132-516c-0e0102967270/status)](https://codeship.io/projects/65819)
[![Code Climate](https://codeclimate.com/github/Sovietaced/edmunds/badges/gpa.svg)](https://codeclimate.com/github/Sovietaced/edmunds)
[![Coverage Status](https://coveralls.io/repos/Sovietaced/edmunds/badge.svg?branch=master)](https://coveralls.io/r/Sovietaced/edmunds?branch=master)
[![Gem Version](https://badge.fury.io/rb/edmunds.svg)](http://badge.fury.io/rb/edmunds)
## Installation
Install the gem
```bash
gem install edmunds
```
Set your API key as a environment variable
```bash
export EDMUNDS_API_KEY=<api_key>
```

## Usage
The module naming scheme of this gem is inline with how the API is documented.
```ruby
require 'edmunds'
=> true
result = Edmunds::Vehicle::Specification::VinDecoding::Full.find("JHMAP11461T005905")
=> #<Edmunds::Vehicle::Specification::VinDecoding::Full:0x007faa2a0e4e40 @make="Honda", @model="S2000", @year=2001>
result = Edmunds::Vehicle::Specification::Style::StylesDetails.find("honda", "s2000", 2001)
 => #<Edmunds::Vehicle::Specification::Style::StylesDetails:0x007fbc719fd028 @count=1, @styles=[#<Edmunds::Vehicle::Specification::Style::Style:0x007fbc719fcf88 @id=100001280, @name="2dr Roadster (2.0L 4cyl 6M)", @trim="Base", @body="Convertible">]> 

```

## Contributors
Feel free to fork this repository and open a pull request. 
If you have any questions you can open an issue or contact me directly [here](https://twitter.com/Sovietaced).

## License

Please see LICENSE at the top level of the repository.

