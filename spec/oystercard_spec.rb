require 'oystercard'

RSpec.describe Card do

  limit = Card::MAXIMUM_LIMIT
subject(:card) {described_class.new}  #enables you to replace subject with card (still creating new instance but easier to read)
let(:entry_station) {double(:station)}
let(:exit_station) {double(:station)}
let(:journey) {double(:journey)}


it 'creates a new card' do
  expect(Card.new).to be_a(Card)
end

context 'balance' do

  it 'has a balance of zero' do
    expect(card.balance).to eq(0)
  end
end

context 'top ups' do

  it {is_expected.to respond_to(:top_up).with(1).argument }

  it 'tops up the balance' do
    expect{card.top_up(1)}.to change{ card.balance }.by(1)
  end

end

context 'maximum limit' do

  it "cannot exceed #{limit}" do
    message = "You cannot exceed the £#{limit} limit!"
		card.top_up(limit)  # the value needs to be less than the limit less what is topped up in test (so if default value = 90, and you top up 1 or more, you need value of 89 or less)
		expect{card.top_up(1)}.to raise_error(message)
  end
end


context 'card in use' do

  it {is_expected.to respond_to(:touch_in)}
  it {is_expected.to respond_to(:touch_out)}
  it {is_expected.to respond_to(:in_journey?)}

  it 'it is not in a journey ?' do
    expect(card.in_journey?).to eq false
  end

end

context 'topped up' do

  it 'needs to be topped up' do
    card.top_up(limit)
  end

  it 'can touch in' do
    card.top_up(limit)
    card.touch_in(entry_station)
    expect(card).to be_in_journey
  end

  it 'can only touch in with a minimum balance of £1' do
    expect{card.touch_in(entry_station)}.to raise_error 'Insufficient money on your card!'
  end

  context '#touch_out' do

    before do
      card.top_up(limit)
      card.touch_in(entry_station)
    end

    it 'can touch out' do
     card.touch_out(exit_station)
     expect(card).not_to be_in_journey
   end

   it 'charges minimum fare at touch_out' do
     expect{card.touch_out(exit_station)}.to change{card.balance}.by (-(Card::MINIMUM_LIMIT))
   end
 end
end

context 'record journeys' do

  before do
  card.top_up(limit)
  end

  it 'starts with empty journey history' do
  expect(card.journey_history).to eq []
  end

  it 'saves current_journey to history when touch out' do
  journey = {:entry_station => entry_station, :exit_station => exit_station}
  card.touch_in(entry_station)
  card.touch_out(exit_station)
  expect(card.journey_history).to eq [journey]
  end

  it 'deducts penalty fare if you touch in twice' do
    card.touch_in(entry_station)
    expect{card.touch_in(entry_station)}.to change{card.balance}.by(-Journey::PENALTY)
  end

  it 'deducts penalty if you touch_out without touching in' do
    expect{card.touch_out(exit_station)}.to change{card.balance}.by(-Journey::PENALTY)
  end

 end
end






