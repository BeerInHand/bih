require 'spec_helper'

describe Brewing::Calculators::Ibu, calculators: true do

  it 'verifies the ibu calculator' do

    volume = Brewing::Units::Volume.new(5, :gallons)
    gravity = Brewing::Units::Gravity.new(1.048, :sg)
    weight = Brewing::Units::Weight.new(1, :ounces)
    hop_form = :pellet
    aau = 10.0
    added_during = :boil
    boil_length = 90
    boil_volume = Brewing::Units::Volume.new(6, :gallons)

    ibu_calc = Brewing::Calculators::Ibu.new(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)

    expect(ibu_calc.ibus.rager.round(1)).to eq(49.6)
    expect(ibu_calc.ibus.tinseth.round(1)).to eq(40.6)

    ibu_calc.hop_form = :leaf

    expect(ibu_calc.ibus.rager.round(1)).to eq(44.7)
    expect(ibu_calc.ibus.tinseth.round(1)).to eq(37.6)
  end
end
