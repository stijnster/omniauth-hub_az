require 'active_support/core_ext'
require 'omniauth-oauth2'

require 'omniauth/hub_az/version'
require 'omniauth/hub_az/hub_az/token'
require 'omniauth/hub_az/hub_az/mixins/controller_helper'
require 'omniauth/hub_az/omni_auth/strategies/hub_az'

module Omniauth
  module HubAz

    mattr_accessor :public_key
    @@public_key = nil

    mattr_accessor :algorithm
    @@algorithm = nil

    def self.setup
      yield self
    end

    class Error < StandardError; end
    # Your code goes here...
  end
end
