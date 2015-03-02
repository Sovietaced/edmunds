#test/test_helper.rb
require './lib/edmunds'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.filter_sensitive_data('EDMUNDS_API_KEY') { ENV['EDMUNDS_API_KEY'] }

  # default quota of 2 API calls/second and 5000 API calls/day.
  # rate limit when really hitting server
  c.after_http_request(:real?)  do |request, response|
    sanitized_uri = request.uri.sub(ENV['EDMUNDS_API_KEY'], 'EDMUNDS_API_KEY')
    $stderr.puts "saving vcr cassette: cassette file missing for #{sanitized_uri}"
    sleep(1)
  end
end

# Test Coverage
require 'coveralls'
Coveralls.wear!