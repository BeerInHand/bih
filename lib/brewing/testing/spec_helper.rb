require 'brewing/testing/fixture_methods'
require 'brewing/constants'

RSpec.configure do |config|
  config.include(Brewing::Constants)
  config.include(Brewing::FixtureMethods)
end
