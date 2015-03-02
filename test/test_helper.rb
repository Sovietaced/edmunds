#test/test_helper.rb
require './lib/edmunds'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.filter_sensitive_data('EDMUNDS_API_KEY') { ENV['EDMUNDS_API_KEY'] }
end