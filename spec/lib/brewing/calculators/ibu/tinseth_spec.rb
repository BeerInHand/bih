require 'spec_helper'

describe Brewing::Calculators::Ibu::Tinseth, calculators: true, ibu: true do

  before(:each) do
    @calc = create_ibu_calc
  end

  it 'verifies the tinseth utilization modifiers for leaf equal 0' do
    @calc.hop_form = :leaf 
    expect(@calc.tinseth.utilization).to eq(@calc.tinseth.utilization_with_modifiers)
  end

  it 'verifies the tinseth ibus and utilization - 90 mins' do
    @calc.boil_length = 90
    expect(@calc.tinseth.ibus.round(1)).to eq(40.6)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.25)
  end

  it 'verifies the tinseth ibus and utilization - 60 mins' do
    @calc.boil_length = 60
    expect(@calc.tinseth.ibus.round(1)).to eq(38.0)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.23)
  end

  it 'verifies the tinseth ibus and utilization - 45 mins' do
    @calc.boil_length = 45
    expect(@calc.tinseth.ibus.round(1)).to eq(34.9)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.22)
  end

  it 'verifies the tinseth ibus and utilization - 30 mins' do
    @calc.boil_length = 30
    expect(@calc.tinseth.ibus.round(1)).to eq(29.2)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.18)
  end

  it 'verifies the tinseth ibus and utilization - 15 mins' do
    @calc.boil_length = 15
    expect(@calc.tinseth.ibus.round(1)).to eq(18.9)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.12)
  end

  it 'verifies the tinseth ibus and utilization - 0 mins' do
    @calc.boil_length = 0
    expect(@calc.tinseth.ibus.round(1)).to eq(0.0)
    expect(@calc.tinseth.utilization.round(2)).to eq(0.0)
  end
end
