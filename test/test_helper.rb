ENV['RAILS_ENV'] ||= 'test'

if ENV['COV'].present?
  require 'simplecov'
  SimpleCov.start 'rails'
end

require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include Sorcery::TestHelpers::Rails::Integration

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
    def login_user(user, password: '12341234')
      post user_sessions_url, params: { email: user.email, password: }
      follow_redirect!
    end

    def logout_user
      delete user_sessions_url
      follow_redirect!
    end
  end
end
