require 'spec_helper'

describe Brewing::Calculators::Decoction, calculators: true, mash: true do

  it 'verifies the decoction calculator' do

    decoction = create_decoction_calculator

    decoction.mash.tap do |m|
      m.volume.quarts = 10
      m.weight.lbs = 10
      m.temperature.f = 154
    end

    added_temp = create_temperature(212, :f)
    final_temp = create_temperature(168, :f)

    weight = decoction.weight_required_for_temperature(added_temp, final_temp)

    expect(weight.lbs.round(2)).to eq(6.0)

    weight.lbs = 8

    added_temp = decoction.temperature_required_for_weight(weight, final_temp)

    expect(added_temp.f.round(1)).to eq(197.5)

  end
end
