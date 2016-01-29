require 'station'

describe Station do
  subject(:station) {described_class.new(1)}

  it 'can access its name' do
    expect(station.name).to eq Station::STATION_LIST[1][0]
  end

  it 'can access its zone' do
    expect(station.zone).to eq Station::STATION_LIST[1][1]
  end
end
