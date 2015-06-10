require 'spec_helper'

describe Beerinhand::Calculators::Srm, calculators: true do

  it 'verifies the srm calculator' do

    srm = Beerinhand::Calculators::Srm.convert(60)

    expect(srm.round(1)).to eq(24.7)

  end
end
