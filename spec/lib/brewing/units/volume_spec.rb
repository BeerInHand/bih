require 'spec_helper'

describe Brewing::Units::Volume, units: true do

  it 'verifies the volume converter' do
    volume = Brewing::Units::Volume.new(1, :liters)

    expect(volume.value).to eq(1.0)
    expect(volume.units).to eq(:liters)
    expect(volume.liters).to eq(1.0)
    expect(volume.gallons).to eq(0.26)

    volume.gallons = 1.0
    expect(volume.units).to eq(:gallons)
    expect(volume.gallons).to eq(1.0)
    expect(volume.liters).to eq(3.79)

  end
end
