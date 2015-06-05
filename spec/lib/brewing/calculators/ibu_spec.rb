require 'spec_helper'

describe Brewing::Calculators::Ibu, calculators: true do

  before(:each) do
    volume = Brewing::Units::Volume.new(5, :gallons)
    gravity = Brewing::Units::Gravity.new(1.048, :sg)
    weight = Brewing::Units::Weight.new(1, :ounces)
    aau = 10.0
    added_during = :boil
    boil_length = 90
    boil_volume = Brewing::Units::Volume.new(6, :gallons)
    hop_form = :pellet

    @calc= Brewing::Calculators::Ibu.new(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)
  end

  it 'verifies the rager calculator - 90 mins' do

    expect(@calc.rager.ibus.round(1)).to eq(49.6)
    expect(@calc.rager.utilization.round(2)).to eq(0.32)

    expect(@calc.tinseth.ibus.round(1)).to eq(40.6)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.25)

    boil_length = 90

    @calc.hop_form = :leaf

    expect(@calc.ibus.rager.round(1)).to eq(44.7)
    expect(@calc.ibus.tinseth.round(1)).to eq(37.6)
  end

  it 'verifies the ibu calculator' do

    expect(@calc.rager.ibus.round(1)).to eq(49.6)
    expect(@calc.rager.utilization.round(2)).to eq(0.32)

    expect(@calc.tinseth.ibus.round(1)).to eq(40.6)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.25)

    boil_length = 90

    @calc.hop_form = :leaf

    expect(@calc.ibus.rager.round(1)).to eq(44.7)
    expect(@calc.ibus.tinseth.round(1)).to eq(37.6)
  end

end
