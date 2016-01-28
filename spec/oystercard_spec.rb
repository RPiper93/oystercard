require "oystercard.rb"
describe OysterCard do
  subject(:oystercard) {described_class.new}

  it "Balance = 0" do
    expect(oystercard.balance).to eq 0
  end

  describe "#top_up" do
    before do
      oystercard.top_up(30)
    end

    it "gets topped up "do
      expect(oystercard.balance).to eq 30
    end

    it "fails for a top-up more than 50" do
      oystercard.top_up(20)
      expect{oystercard.top_up(1)}.to raise_error "Max reached which is #{OysterCard::LIMIT}"
    end
  end

  describe 'journey' do
    let(:station) {double(:station)}
    let(:station2) {double(:station2)}
    let(:station3) {double(:station3)}
    before do
      oystercard.top_up(10)
    end

    context 'touch_in' do
      it 'card has at least £1' do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        expect{oystercard.touch_in(station)}.to raise_error "Insufficient balance #{OysterCard::MINIMUM}"
      end

      it 'has entry station' do
        oystercard.touch_in(station)
        expect(oystercard.history).to eq [station, nil]
      end
    end

    context 'touch_out' do

      it 'taps-out' do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        expect(oystercard.history).to eq [station, station]
      end

      it 'charges on touch_out' do
        oystercard.touch_in(station)
        expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-10)
      end

      it 'remembers exit station' do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        expect(oystercard.history).to eq [station, station]
      end

      it 'records journey history' do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        expect(oystercard.full_history).to eq ({oystercard.time=>[station, station]})
      end

      it 'deducts a penalty charge if user fails to touch out' do
        oystercard.top_up(30)
        oystercard.touch_in(station)
        expect {oystercard.touch_in(station)}.to change{oystercard.balance}.by(-6)
      end
      it 'deducts a penalty charge if user fails to touch in'do
        oystercard.top_up(30)
        expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-16)

      end
      it 'deducts a penalty charge if user fails to touch in on second journey'do
        oystercard.top_up(30)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect {oystercard.touch_out(station3)}.to change{oystercard.balance}.by(-16)
      end
      it 'doesn\'t change history when you touch out without touching in'do
        oystercard.top_up(30)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        1000000.times{p "time wasting!"}
        oystercard.touch_out(station3)
        expect(oystercard.full_history).to eq ({oystercard.time=>[station, station2]})
      end

    end
  end
end
