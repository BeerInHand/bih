require 'spec_helper'

describe Beerinhand::Calculators::Ibu::Rager, calculators: true, ibu: true do

  before(:each) do
    @calc = create_ibu_calc
  end

  it 'verifies the rager utilization modifiers for pellets equal 0' do
    @calc.hop_form = :pellets 
    expect(@calc.rager.utilization).to eq(@calc.rager.utilization_with_modifiers)
  end

  it 'verifies the rager ibus and utilization - 90 mins' do
    @calc.boil_length = 90
    expect(@calc.rager.ibus.round(1)).to eq(47.8)
    expect(@calc.rager.utilization.round(2)).to eq(0.32)
  end

  it 'verifies the rager ibus and utilization - 60 mins' do
    @calc.boil_length = 60
    expect(@calc.rager.ibus.round(1)).to eq(46.2)
    expect(@calc.rager.utilization.round(2)).to eq(0.31)
  end

  it 'verifies the rager ibus and utilization - 45 mins' do
    @calc.boil_length = 45
    expect(@calc.rager.ibus.round(1)).to eq(40.3)
    expect(@calc.rager.utilization.round(2)).to eq(0.27)
  end

  it 'verifies the rager ibus and utilization - 30 mins' do
    @calc.boil_length = 30
    expect(@calc.rager.ibus.round(1)).to eq(25.6)
    expect(@calc.rager.utilization.round(2)).to eq(0.17)
  end

  it 'verifies the rager ibus and utilization - 15 mins' do
    @calc.boil_length = 15
    expect(@calc.rager.ibus.round(1)).to eq(12.3)
    expect(@calc.rager.utilization.round(2)).to eq(0.08)
  end

  it 'verifies the rager ibus and utilization - 0 mins' do
    @calc.boil_length = 0
    expect(@calc.rager.ibus.round(1)).to eq(7.7)
    expect(@calc.rager.utilization.round(2)).to eq(0.05)
  end
end
  