# Omniauth::HubAz

An omniauth gem to authenticate with hub-az

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-hub_az'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install omniauth-hub_az

## Usage


### Configration

Create an initializer file and configure the following parameters;

```ruby
Omniauth::HubAz.setup do |config|
  config.public_key = OpenSSL::PKey::RSA.new(Rails.application.credentials.hub_az[:public_key])
  config.algorithm = 'RS512'
end
```

### Use with Devise

Configure the `devise.rb` initializer;

```ruby
  config.omniauth :hub_az, Rails.application.credentials.hub_az[:client_id], Rails.application.credentials.hub_az[:client_secret]
```

Change your routes file to handle omniauth authentication;
```ruby
  #...
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```

and create that controller
```ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def hub_az
    authorization = request.env["omniauth.auth"]

    # test that the info is valid? (verification with the public key was successfull)
    if authorization.info.valid? && authorization.info.roles.include?('some-role')
      @user = User.find_or_initialize_by(email: authorization.info.email) do |user|
        user.password = Devise.friendly_token[0, 20]
      end
      # set additional attributes that should be updated after each authentication
      @user.save!

      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path, alert: 'Unable to login, make sure you have the correct roles assigned.'
    end
  end

end
```

### Api Controller validation

Include the mixin to your API controller to obtain additional methods to valid an incoming Bearer token;

```ruby
class Api::V1::ExampleController < ApplicationController

  include Omniauth::HubAz::Mixins::ControllerHelper

  before_action :valid_hub_az_token_required!
  before_action do
    hub_az_token_requires_role!('some-api-role')
  end

end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stijnster/omniauth-hub_az. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/stijnster/omniauth-hub_az/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::HubAz project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/stijnster/omniauth-hub_az/blob/master/CODE_OF_CONDUCT.md).
