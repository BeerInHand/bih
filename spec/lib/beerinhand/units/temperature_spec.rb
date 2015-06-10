require 'spec_helper'

describe Beerinhand::Units::Temperature, units: true do

  it 'verifies the temperature converter' do
    temperature = Beerinhand::Units::Temperature.new(100, :c)

    expect(temperature.value).to eq(100.0)
    expect(temperature.units).to eq(:c)
    expect(temperature.c).to eq(100.0)
    expect(temperature.f).to eq(212.0)

    temperature.f = 122
    expect(temperature.units).to eq(:f)
    expect(temperature.f).to eq(122.0)
    expect(temperature.c).to eq(50.0)

  end
end
