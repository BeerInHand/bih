require 'spec_helper'

describe Brewing::Calculators::NaturalCarbonation, calculators: true do

  it 'verifies the natural carbonation calculator' do

    natural = create_natural_carbonation

    expect(natural.saturated_co2.round(2)).to eq(0.98)

    expect(natural.corn_sugar.grams.round(0)).to eq(92)
    expect(natural.cane_sugar.grams.round(0)).to eq(101)

  end
end
