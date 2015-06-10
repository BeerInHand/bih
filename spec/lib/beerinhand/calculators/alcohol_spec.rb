require 'spec_helper'

describe Beerinhand::Calculators::Alcohol, calculators: true do

  it 'verifies the alcohol calculator' do

    og = Beerinhand::Units::Gravity.new(1.048, :sg)
    fg = Beerinhand::Units::Gravity.new(1.012, :sg)
    alcohol = Beerinhand::Calculators::Alcohol.new(og, fg)

    expect(alcohol.abv).to eq(4.6)
    expect(alcohol.abw).to eq(3.7)
    expect(alcohol.calories.round(2)).to eq(13.14)

    alcohol.original_gravity.sg = 1.096
    alcohol.final_gravity.sg = 1.022

    expect(alcohol.abv).to eq(9.7)
    expect(alcohol.abw).to eq(7.8)
    expect(alcohol.calories.round(2)).to eq(26.71)

  end
end
