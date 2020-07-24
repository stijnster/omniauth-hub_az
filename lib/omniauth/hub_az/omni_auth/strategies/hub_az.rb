require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class HubAz < OmniAuth::Strategies::OAuth2
      attr_reader :hub_az_token

      option :name, 'hub_az'
      option :client_options, {:site => 'https://www.hub-az.nl' }

      uid{ hub_az_token.payload[:sub] if hub_az_token.present? }

      info do
        info = {
          verified?: hub_az_token.verified?,
          roles: hub_az_token.roles
        }

        if hub_az_token.payload.key?(:user)
          info[:email] = hub_az_token.payload[:user][:email]
          info[:first_name] = hub_az_token.payload[:user][:first_name]
          info[:last_name] = hub_az_token.payload[:user][:last_name]
          info[:full_name] = hub_az_token.payload[:user][:full_name]
        end

        info
      end

      extra do
        { raw_info: { payload: hub_az_token.payload, header: hub_az_token.header } }
      end

      def hub_az_token
        return @hub_az_token if defined?(@hub_az_token)

        @hub_az_token = ::HubAz::Token.verify!(access_token.token)
        fail!(:invalid_credentials, CallbackError.new(:invalid_credentials, 'Invalid JWT token')) unless @hub_az_token.verified?

        @hub_az_token
      end
    end
  end
end