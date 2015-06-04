require 'spec_helper'

describe Brewing::Calculators::Hydrometer, calculators: true do

  it 'verifies the hydrometer calculator' do

    gravity = Brewing::Units::Gravity.new(1.048, :sg)
    temp = Brewing::Units::Temperature.new(150, :f)
    hydro = Brewing::Calculators::Hydrometer.new(gravity, temp)

    expect(hydro.correct_gravity.sg).to eq(1.067)
  end
end
