require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#initialise' do
    it "starts with balance 0" do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "can be topped up" do
      oystercard.top_up(15)
      expect(oystercard.balance).to eq 15
    end
  end

end