require 'bundler'
Bundler.setup(:default, :development)
require 'simplecov'
Bundler.require

require 'rubycas-client'

Dir["./spec/support/**/*.rb"].each do |f|
  require f unless f.end_with? '_spec.rb'
end

require 'database_cleaner'

RSpec.configure do |config|
  config.mock_with :rspec
  config.mock_framework = :rspec
  config.include ActionControllerHelpers

  config.before(:all) do
  end

  config.after(:suite) do
    ActiveRecordHelpers.teardown_active_record
  end
  config.before(:suite) do
    ActiveRecordHelpers.setup_active_record
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

