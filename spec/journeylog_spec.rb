describe JourneyLog do

subject(:log) {described_class.new}
let(:station) {double(:station, name: "station", zone: 1)}

      it 'records journey history' do
        log.start_journey(station)
        log.exit_journey(station)
        current = log.current_journey
        log.log
        expect(log.journeys).to eq (["station -> station"])
      end

end
