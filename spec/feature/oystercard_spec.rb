require 'oystercard.rb'
require 'station'
require 'journey'
# In order to know where I have been
# As a customer
# I want to see to all my previous trips

describe 'User stories' do
  let(:station) {Station.new("liverpool street", 1)}
  let(:station2) { Station.new("Brighton", 10)}
  let(:station3) { Station.new("Victoria", 1)}
  let(:oystercard) {OysterCard.new}
  it 'shows all previous trips' do
    oystercard = OysterCard.new
    oystercard.top_up(20)
    oystercard.touch_in(station)
    oystercard.touch_out(station2)
    expect(oystercard.full_history).to eq ({oystercard.time=>[station, station2]})
  end

  it 'doesn\'t change history when you touch out without touching in'do
    oystercard = OysterCard.new
    oystercard.top_up(30)
    oystercard.touch_in(station)
    oystercard.touch_out(station2)
    oystercard.touch_out(station3)
    expect(oystercard.full_history).to eq ({oystercard.time=>[nil, station3]})
  end

#  In order to know how far I have travelled
#  As a customer
#  I want to know what zone a station is in
  it 'knows what zone a station is in' do
    oystercard = OysterCard.new
    station = Station.new("liverpool street", 1)

    expect(station[:zone]).to eq 1
  end

#   In order to be charged correctly
#   As a customer
#   I need a penalty charge deducted if I fail to touch in or out

  it 'deducts a penalty charge if user fails to touch in or out' do
    oystercard.top_up(50)
    oystercard.touch_in(station)
    expect {oystercard.touch_in(station)}.to change{oystercard.balance}.by(-6)
  end
end
