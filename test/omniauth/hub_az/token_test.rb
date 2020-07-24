require 'test_helper'

class Omniauth::HubAz::TokenTest < Minitest::Test
  def setup
    @rsa = OpenSSL::PKey::RSA.generate(1024)
  end

  def generate_jtw(payload:, headers: {})
    JWT.encode(payload, @rsa, 'RS512', headers)
  end

  def test_verify_method_present_on_class
    assert Omniauth::HubAz::Token.respond_to?(:verify!)
  end

  def test_failing_verify_method
    jwt = 'eyJraWQiOiJ0blFQOTVUQURYOXVzdmFKbWw5bmVzanhKYXl4bTVwRGhEWk8teDhjS0gwIiwiYWxnIjoiUlM1MTIifQ.eyJpc3MiOiJ3d3cuaHViLWF6Lm5sIiwiaWF0IjoxNTk1NDkyODQxLCJleHAiOjE1OTU1MDAwNDEsImp0aSI6ImU3ZTZiMzZiLWNhMDYtNGIxYS05MDQ3LWU1MmIzZmM2MDY3MiIsInN1YiI6InRuUVA5NVRBRFg5dXN2YUptbDluZXNqeEpheXhtNXBEaERaTy14OGNLSDAiLCJyb2xlcyI6WyJzc28uYWRtaW4iLCJ3by5hZG1pbiJdLCJjbGllbnQiOnsibmFtZSI6IlRlc3QgQXBwIC0gQVBJIn19.vm5s3IrvLK6VEJ78M8D7de3rVHfAcaxWxuD9kzwjKjPQImPSgFdrtvUUkoWeybmqCOWPVYBfOUuJHOIkFVsWTgS7AYe0EQxIwXtuxbnalSGWgqHMS1NiqtsfKDcLyWtznXSeCLH0qVb65Rz4pfDcGi3CkPXO-hrZ6OII_6TlX_o'
    token = Omniauth::HubAz::Token.new(jwt, public_key: @rsa.public_key, algorithm: 'RS512')
    assert_instance_of Omniauth::HubAz::Token, token
    refute token.valid?
  end

  def test_failing_expired_token
    jwt = generate_jtw(payload: { me: 'myself', exp: 3.hours.ago.utc.to_i }, headers: { and: 'I' })
    refute Omniauth::HubAz::Token.new(jwt, public_key: @rsa.public_key, algorithm: 'RS512').valid?
  end

  def test_verify_method_on_class_returns_valid_token
    jwt = generate_jtw(payload: { iss: 'www.hub-az.nl', exp: 10.minutes.from_now.utc.to_i, roles: [ 'role-a', 'role-b' ] }, headers: { and: 'I' })

    token = Omniauth::HubAz::Token.new(jwt, public_key: @rsa.public_key, algorithm: 'RS512')
    refute_nil token
    assert_instance_of Omniauth::HubAz::Token, token
    assert token.valid?
    assert_equal [ 'role-a', 'role-b' ], token.roles
    assert token.has_role?('role-a')
    assert token.has_role?('role-b')
    refute token.has_role?('role-c')
  end

  def test_with_missing_roles
    jwt = generate_jtw(payload: { iss: 'www.hub-az.nl', exp: 10.minutes.from_now.utc.to_i }, headers: { and: 'I' })

    token = Omniauth::HubAz::Token.new(jwt, public_key: @rsa.public_key, algorithm: 'RS512')
    assert token.valid?
    assert_equal [], token.roles
    refute token.has_role?('role-a')
    refute token.has_role?('role-b')
    refute token.has_role?('role-c')
  end
end