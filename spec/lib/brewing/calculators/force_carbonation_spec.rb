require 'spec_helper'

describe Brewing::Calculators::ForceCarbonation, calculators: true do

  it 'verifies the force carbonation calculator' do

    temp = Brewing::Units::Temperature.new(62, :f)
    regulator = Brewing::Calculators::ForceCarbonation.new(temp, 2.5)

    expect(regulator.psi).to eq(24.2)
    expect(regulator.desired_co2).to eq(2.5)
  end
end
