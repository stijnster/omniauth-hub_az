require "test_helper"

class Omniauth::HubAzTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Omniauth::HubAz::VERSION
  end

  def test_it_does_something_useful
    assert HubAz::Token.respond_to?(:verify!)
  end
end
