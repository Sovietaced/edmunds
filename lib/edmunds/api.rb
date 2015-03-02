module Edmunds
  module Api

    URL = "https://api.edmunds.com/api"
    URL_V1 = "#{URL}/v1"

    # Wrapper around Faraday.get that passses the API key
    def self.get(url)
      Faraday.get(url, { api_key: ENV['EDMUNDS_API_KEY'] })
    end

  end
end