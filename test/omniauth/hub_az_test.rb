require "test_helper"

class Omniauth::HubAzTest < Minitest::Test

  def setup
    @rsa = OpenSSL::PKey::RSA.generate(1024)
    puts "generated a new key"
  end

  def test_that_it_has_a_version_number
    refute_nil ::Omniauth::HubAz::VERSION
  end

  def test_it_does_something_useful
    assert HubAz::Token.respond_to?(:verify!)
  end
end


require 'test_helper'

# class HubAz::TokenTest < ActiveSupport::TestCase
#   # setup do
#   #   @rsa = OpenSSL::PKey::RSA.generate(1024)
#   #   HubAz::Token.public_key = @rsa.public_key
#   #   HubAz::Token.algorithm = 'RS512'
#   # end

#   # def generate_jtw(payload = {}, headers = {})
#   #   JWT.encode(payload, @rsa, 'RS512', headers)
#   # end

#   # test 'public key assignment' do
#   #   assert_equal @rsa.public_key.to_s, HubAz::Token.public_key.to_s
#   # end

#   # test 'failing verify method' do
#   #   jwt = 'eyJraWQiOiJ0blFQOTVUQURYOXVzdmFKbWw5bmVzanhKYXl4bTVwRGhEWk8teDhjS0gwIiwiYWxnIjoiUlM1MTIifQ.eyJpc3MiOiJ3d3cuaHViLWF6Lm5sIiwiaWF0IjoxNTk1NDkyODQxLCJleHAiOjE1OTU1MDAwNDEsImp0aSI6ImU3ZTZiMzZiLWNhMDYtNGIxYS05MDQ3LWU1MmIzZmM2MDY3MiIsInN1YiI6InRuUVA5NVRBRFg5dXN2YUptbDluZXNqeEpheXhtNXBEaERaTy14OGNLSDAiLCJyb2xlcyI6WyJzc28uYWRtaW4iLCJ3by5hZG1pbiJdLCJjbGllbnQiOnsibmFtZSI6IlRlc3QgQXBwIC0gQVBJIn19.vm5s3IrvLK6VEJ78M8D7de3rVHfAcaxWxuD9kzwjKjPQImPSgFdrtvUUkoWeybmqCOWPVYBfOUuJHOIkFVsWTgS7AYe0EQxIwXtuxbnalSGWgqHMS1NiqtsfKDcLyWtznXSeCLH0qVb65Rz4pfDcGi3CkPXO-hrZ6OII_6TlX_o'
#   #   assert_nil HubAz::Token.verify!(jwt)
#   # end

#   # test 'failing expired token' do
#   #   jwt = generate_jtw({ me: 'myself', exp: 3.hours.ago.utc.to_i }, { and: 'I' })
#   #   assert_nil HubAz::Token.verify!(jwt)
#   # end

#   # test 'verify method on class returns token object' do
#   #   jwt = generate_jtw({ iss: 'www.hub-az.nl', exp: 10.minutes.from_now.utc.to_i, roles: [ 'role-a', 'role-b' ] }, { and: 'I' })
#   #   token = HubAz::Token.verify!(jwt)
#   #   assert_not_nil token
#   #   assert_equal [ 'role-a', 'role-b' ], token.roles
#   #   assert token.has_role?('role-a')
#   #   assert token.has_role?('role-b')
#   #   refute token.has_role?('role-c')
#   # end

#   # test 'with missing roles' do
#   #   jwt = generate_jtw({ iss: 'www.hub-az.nl', exp: 10.minutes.from_now.utc.to_i }, { and: 'I' })
#   #   token = HubAz::Token.verify!(jwt)
#   #   assert_equal [], token.roles
#   #   refute token.has_role?('role-a')
#   #   refute token.has_role?('role-b')
#   #   refute token.has_role?('role-c')
#   # end
# end
