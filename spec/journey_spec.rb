require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:station) {double(:station)}

  it 'starts with an empty journey' do
    expect(journey.current).to eq({})
  end

  it 'stores entry station' do
    journey.start(station)
    expect(journey.current[:entry_station]).to eq station
  end

  it 'stores exit station' do
    journey.start(station)
    journey.end(station)
    expect(journey.current[:exit_station]).to eq station
  end

  it '#reset' do
    journey.start(station)
    journey.end(station)
    journey.reset
    expect(journey.current).to eq({})
  end

  it 'knows when travelling' do
    journey.start(station)
    expect(journey).to be_travelling
  end
  
  describe '#fare' do
    it 'penalty when only one station' do
      journey.start(station)
      expect(journey.fare).to eq(Journey::PENALTY)
    end
    it 'minimum fare if complete journey' do
      journey.start(station)
      journey.end(station)
      expect(journey.fare).to eq(Journey::MINIMUM_FARE)
    end
  end

end











