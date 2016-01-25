require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#initialise' do
    it "starts with balance 0" do
      expect(oystercard.balance).to eq 0
    end

    it "doesn't start in journey" do
      expect(oystercard).to_not be_in_journey
    end
  end

  describe '#top_up' do
    it "can be topped up" do
      oystercard.top_up(15)
      expect(oystercard.balance).to eq 15
    end

    it "can't have more than £90" do
      max_balance = Oystercard::MAX
      oystercard.top_up(max_balance)
      expect {oystercard.top_up(1)}.to raise_error "Maximum balance: #{max_balance} reached"
    end
  end

  describe '#touch in/#touch out' do

    before do
      oystercard.top_up(1)
      oystercard.touch_in
    end

    context "#touch_in" do

      it 'can touch in' do
        expect(oystercard).to be_in_journey
      end

      it "can't touch in with balance less than £1" do
        oystercard.touch_out
        expect {oystercard.touch_in}.to raise_error "Under value - Additional fare due"
      end
    end

    context "#touch_out" do

      it 'can touch out' do
        oystercard.touch_out
        expect(oystercard).to_not be_in_journey
      end

      it "deducts minimum fare" do
        min_balance = Oystercard::MIN
        expect {oystercard.touch_out}.to change{oystercard.balance}.by(-min_balance)
      end

    end

  end

end