require 'spec_helper'

describe Brewing::Calculators::Dilution, calculators: true do

  it 'verifies the dilution calculator' do

    dilution = create_dilution_calculator

    dilution.wort.gravity.sg = 1.050

    wort_added = create_wort.tap { |wort| wort.gravity.sg = 1.000 }

    wort_final = dilution.add_wort(wort_added)

    expect(wort_final.gravity.sg).to eq(1.025)

  end
end
