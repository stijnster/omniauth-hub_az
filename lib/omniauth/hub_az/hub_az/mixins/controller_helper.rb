module HubAz
  module Mixins
    module ControllerHelper

      private

        def hub_az_token_has_role(role)
          head 401 unless (hub_az_token.valid? && hub_az_token.has_role?(role))
        end

        def valid_hub_az_token_required!
          head 401 unless hub_az_token.valid?
        end

        def hub_az_token
          return @hub_az_token if defined?(@hub_az_token)

          @hub_az_token = HubAz::Token.verify!(hub_az_jwt_token)
        end

        def hub_az_jwt_token
          return @hub_az_jwt_token if defined?(@hub_az_jwt_token)

          @hub_az_jwt_token = request.headers['Authorization'].to_s.split(' ').last
        end

    end
  end
end