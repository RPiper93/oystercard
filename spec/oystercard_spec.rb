require "oystercard.rb"
require "journeylog.rb"

describe OysterCard do
  subject(:oystercard) {described_class.new}

  describe '#balance'do

    it "shows an initial balance" do
      expect(oystercard.balance).to eq OysterCard::INITIAL_BALANCE
    end
  end

  describe "#top_up" do

    it "gets topped up "do
      expect{oystercard.top_up 10}.to change{oystercard.balance}.by(10)
    end

    it "fails for a top-up more than 50" do
      oystercard.top_up(OysterCard::LIMIT - OysterCard::INITIAL_BALANCE)
      expect{oystercard.top_up(1)}.to raise_error "Max reached which is #{OysterCard::LIMIT}"
    end
  end

  describe 'journey' do
    let(:station) {double(zone: 1, name: "station")}
    let(:station2) {double(zone: 2, name: "station2")}
    let(:station3) {double(zone: 3, name: "station3")}

    context 'touch_in' do
      it 'raises an error if card doesn\'t have £1' do
        30.times do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        end
        expect{oystercard.touch_in(station)}.to raise_error "Insufficient balance #{OysterCard::MINIMUM}"
      end
    end

    context 'touch_out' do

      it 'charges on touch_out' do
        oystercard.touch_in(station)
        expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
      end

      it 'deducts a penalty charge if user fails to touch out' do
        oystercard.touch_in(station)
        expect {oystercard.touch_in(station)}.to change{oystercard.balance}.by(-6)
      end
      it 'deducts a penalty charge if user fails to touch in'do
        expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-6)

      end
      it 'deducts a penalty charge if user fails to touch in on second journey'do
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect {oystercard.touch_out(station3)}.to change{oystercard.balance}.by(-6)
      end

    end
  end
end
