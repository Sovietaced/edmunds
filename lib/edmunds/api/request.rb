require 'active_support/core_ext/hash'

module Edmunds
  module Api
    class Request
      attr_writer :raw_parameters, :allowed_parameters, :default_parameters, :required_parameters
      attr_reader :path

      def initialize(path)
        @path = path
        @allowed_parameters = {}
        @default_parameters = {}
      end

      def parameters
        sanitized_parameters
      end

      def get
        Faraday.get(@path, parameters)
      end

      private

      def sanitized_parameters
        @allowed_parameters = @allowed_parameters.with_indifferent_access

        params = @raw_parameters.with_indifferent_access

        # merge in default parameters
        params.reverse_merge! @default_parameters

        # throw away unknown parameters
        params.slice! *@allowed_parameters.keys

        # confirm required parameters are present
        check_required(params)

        # confirm parameter values are allowed
        check_values(params)

        # merge or override api_key
        params.merge! api_key
      end

      def check_required(params)
        return params if params.empty?
        @required_parameters.each do |param|
          raise "missing required parameter #{param}" if params[param].blank?
        end
        params
      end

      def check_values(params)
        return params if params.empty?
        params.each do |param, value|
          raise "bad parameter value #{value} for param #{param}" unless valid_param?(param, value)
        end
        params
      end

      def valid_param?(param, value)
        constraint = @allowed_parameters[param]

        if constraint == :anything
          true
        elsif constraint.respond_to?(:cover?)
          constraint.cover?(value)
        elsif constraint.respond_to?(:match)
          !! constraint.match(value)
        else
          constraint.include?(value)
        end
      end

      def api_key
        { api_key: ENV['EDMUNDS_API_KEY'] }
      end
    end
  end
end