# edmunds 
Edmunds.com Ruby API Wrapper 

[Codeship Status for sovietaced/edmunds](https://codeship.io/projects/d03c61a0-a2bc-0132-516c-0e0102967270/status)

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
```ruby
require 'edmunds'
=> true
result = Edmunds::Vehicle::Specification::VinDecoding::Basic.find("JHMAP11461T005905")
=> #<Edmunds::Vehicle::Specification::VinDecoding::Basic:0x007faa2a0e4e40 @make="Honda", @model="S2000", @year=2001>

```
## License

Please see LICENSE at the top level of the repository.
