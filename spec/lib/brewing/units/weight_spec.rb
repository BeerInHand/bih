require 'spec_helper'

describe Brewing::Units::Weight, units: true do

  it 'verifies the weight converter' do
    weight = Brewing::Units::Weight.new(1, :ounces)

    expect(weight.value).to eq(1.0)
    expect(weight.units).to eq(:ounces)
    expect(weight.ounces).to eq(1.0)
    expect(weight.grams).to eq(28.35)

    weight.grams = 283.5
    expect(weight.units).to eq(:grams)
    expect(weight.grams).to eq(283.5)
    expect(weight.ounces).to eq(10.0)

  end
end
