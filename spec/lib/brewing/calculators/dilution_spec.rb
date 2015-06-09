require 'spec_helper'

describe Brewing::Calculators::Dilution, calculators: true do

  it 'verifies the dilution calculator' do


    wort_start = create_wort(gravity: 1.050)
    wort_added = create_wort(gravity: 1.000)

    dilution = create_dilution_calculator(wort: wort_start)

    wort_final = dilution.add_wort(wort_added)

    expect(wort_final.gravity.sg).to eq(1.025)

  end
end
