require 'spec_helper'

describe Beerinhand::Units::Volume, units: true do

  it 'verifies the volume converter' do
    volume = Beerinhand::Units::Volume.new(1, :liters)

    expect(volume.value).to eq(1.0)
    expect(volume.units).to eq(:liters)
    expect(volume.liters).to eq(1.0)
    expect(volume.gallons.round(2)).to eq(0.26)

    volume.gallons = 1.0
    expect(volume.units).to eq(:gallons)
    expect(volume.gallons).to eq(1.0)
    expect(volume.liters.round(2)).to eq(3.79)

  end
end
