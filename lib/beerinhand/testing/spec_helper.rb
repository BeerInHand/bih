require 'beerinhand/testing/fixture_methods'
require 'beerinhand/constants'

RSpec.configure do |config|
  config.include(Beerinhand::Constants)
  config.include(Beerinhand::FixtureMethods)
end
