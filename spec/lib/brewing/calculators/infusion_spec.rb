require 'spec_helper'

describe Brewing::Calculators::Infusion, calculators: true, mash: true do

  it 'verifies the infusion calculator' do

    infusion = create_infusion_calculator

    infusion.mash.tap do |m|
      m.volume.quarts = 0
      m.weight.lbs = 10
      m.temperature.f = 60
    end

    final_temp = create_temperature(154, :f)
    volume = create_volume(10, :quarts)

    added_temp = infusion.temperature_required_for_volume(volume, final_temp)

    expect(added_temp.f.round(1)).to eq(172.0)

    added_temp.f = 176

    volume = infusion.volume_required_for_temperature(added_temp, final_temp)

    expect(volume.quarts.round(2)).to eq(8.19)

  end
end
