module Edmunds
  module Api
    URL = 'https://api.edmunds.com/api'
    URL_V1 = "#{URL}/v1"

    # Wrapper around Faraday.get that passses the API key
    def self.get(url)
      request = Request.new(url)
      yield request
      response = request.get

      if not response.success?
        raise Exception.new(response)
      end

      return response
    end

    class Exception < StandardError
      attr_reader :error_type, :message
      def initialize(response)
        error = JSON.parse(response.body)

        @error_type = error['errorType']
        @message = error['message']
      end
    end
  end
end
