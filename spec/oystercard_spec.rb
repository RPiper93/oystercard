require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "starts with balance 0" do
    expect(oystercard.balance).to eq 0
  end
end