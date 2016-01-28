require 'station'

describe Station do
  
  let(:name){"name"}
  let(:zone){"zone"}
  subject(:station){described_class.new(name, zone)}

  it 'returns name of station' do
    expect(station.name).to eq(name)
  end

  it 'returns name of zone' do
    expect(station.zone).to eq(zone)
  end

end
