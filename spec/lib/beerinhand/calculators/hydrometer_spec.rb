require 'spec_helper'

describe Beerinhand::Calculators::Hydrometer, calculators: true do

  it 'verifies the hydrometer calculator' do

    gravity = Beerinhand::Units::Gravity.new(1.048, :sg)
    temp = Beerinhand::Units::Temperature.new(150, :f)
    hydro = Beerinhand::Calculators::Hydrometer.new(gravity, temp)

    expect(hydro.correct_gravity.sg).to eq(1.067)
  end
end
