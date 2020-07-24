module HubAz
  class Token

    attr_reader :payload, :header

    def self.verify!(jwt)
      self.new(jwt)
    end

    def initialize(jwt, public_key: nil, algorithm: nil)
      public_key = Rails.application.config.hub_az_token[:public_key] if public_key.blank?
      algorithm = Rails.application.config.hub_az_token[:algorithm] if algorithm.blank?

      @decoded = JWT.decode(jwt, public_key, true, algorithm: algorithm)

      @payload = ActiveSupport::HashWithIndifferentAccess.new(@decoded[0])
      @header = ActiveSupport::HashWithIndifferentAccess.new(@decoded[1])

      @verified = true
    rescue JWT::VerificationError, JWT::ExpiredSignature, JWT::DecodeError, JWT::IncorrectAlgorithm
      @payload = {}
      @header = {}
      @verified = false
    end

    def verified?
      !!@verified
    end

    def roles
      @payload[:roles] || []
    end

    def has_role?(role)
      roles.include?(role)
    end
  end
end