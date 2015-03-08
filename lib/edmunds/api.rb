module Edmunds
  module Api
    URL = 'https://api.edmunds.com/api'
    URL_V1 = "#{URL}/v1"

    # Wrapper around Faraday.get that passses the API key
    def self.get(url, api_params = {})
      api_key_hash = { api_key: ENV['EDMUNDS_API_KEY'] }
      api_params = api_params.merge(api_key_hash)
      response = Faraday.get(url, api_params)

      if not response.success?
        raise Exception.new(response)
      end

      return response
    end

    class Exception < StandardError
      attr_reader :error_type, :message
      def initialize(response)
        error = JSON.parse(response.body)

        @error_type = error['error']['errorType']
        @message = error['error']['message']
      end
    end
  end
end
