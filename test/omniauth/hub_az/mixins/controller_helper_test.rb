require 'test_helper'

class Omniauth::HubAz::Mixins::ControllerHelperTest  < Minitest::Test

  class FakeController
    class Request
      attr_accessor :headers

      def initialize
        @headers = {}
      end
    end

    include Omniauth::HubAz::Mixins::ControllerHelper
    attr_reader :request

    def initialize
      @request = Request.new
    end

    def head(code)
      code
    end
  end

  def test_fake_controller
    controller = FakeController.new
    assert_nil controller.send(:hub_az_jwt_token)
  end

  def test_fake_controller_with_invalid_bearer_header
    controller = FakeController.new

    controller.request.headers['Authorization'] = 'Bearer blah'
    assert_equal 'Bearer blah', controller.request.headers['Authorization']
    assert_equal 'blah', controller.send(:hub_az_jwt_token)
    refute controller.send(:hub_az_token).valid?
    assert_equal 401, controller.send(:valid_hub_az_token_required!)
    assert_equal 401, controller.send(:hub_az_token_requires_role!, 'role-a')
  end

  def test_with_valid_bearer_header
    rsa = OpenSSL::PKey::RSA.generate(1024)
    Omniauth::HubAz.setup do |config|
      config.public_key = rsa.public_key
      config.algorithm = 'RS512'
    end
    jwt = JWT.encode({ iss: 'www.hub-az.nl', exp: 10.minutes.from_now.utc.to_i, roles: [ 'role-a', 'role-b' ] }, rsa, 'RS512', { and: 'I' })

    controller = FakeController.new
    controller.request.headers['Authorization'] = "Bearer #{jwt}"
    assert controller.send(:hub_az_token).valid?

    assert_nil controller.send(:valid_hub_az_token_required!)
    assert_nil controller.send(:hub_az_token_requires_role!, 'role-a')
    assert_nil controller.send(:hub_az_token_requires_role!, 'role-b')
    assert_equal 401, controller.send(:hub_az_token_requires_role!, 'role-c')
  end


end