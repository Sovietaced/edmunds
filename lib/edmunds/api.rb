module Edmunds
  module Api
    URL = 'https://api.edmunds.com/api'
    URL_V1 = "#{URL}/v1"

    # Wrapper around Faraday.get that passses the API key
    def self.get(url, api_params = {})
      api_key_hash = { api_key: ENV['EDMUNDS_API_KEY'] }
      api_params = api_params.merge(api_key_hash)
      Faraday.get(url, api_params)
    end
  end
end
