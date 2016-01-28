require 'journey'

describe Journey do
  subject(:journey){described_class.new}
  let(:station) {double :station}
  let(:station2) {double :station2}
  describe '#fare'do
    context 'deducts a fare based on zones'do

      it ' deducts 1 for zone 2 to zone 2'do
        allow(station).to receive(:zone){2}
        journey.entry_station = station
        journey.exit_station = station
        expect(journey.fare).to eq 1
      end

      it 'deducts 2 for zone 2 to zone 3'do
        allow(station).to receive(:zone){2}
        journey.entry_station = station
        allow(station2).to receive(:zone){3}
        journey.exit_station = station2
        expect(journey.fare).to eq 2

      end

    end
  end
end
