require 'spec_helper'

describe Beerinhand::Units::Gravity, units: true do

  it 'verifies the gravity converter' do
    gravity = Beerinhand::Units::Gravity.new(1.048, :sg)

    expect(gravity.value).to eq(1.048)
    expect(gravity.units).to eq(:sg)
    expect(gravity.sg).to eq(1.048)
    expect(gravity.plato).to eq(11.9)

    gravity.plato = 12.0
    expect(gravity.units).to eq(:plato)
    expect(gravity.plato).to eq(12.0)
    expect(gravity.sg).to eq(1.048)

  end
end
