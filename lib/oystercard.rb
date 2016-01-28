require 'journey.rb'

class Card

MINIMUM_LIMIT = 1
MAXIMUM_LIMIT = 90

	attr_reader :balance, :journey_history

	def initialize
		@balance = 0
    @journey_history = []
    @current_journey = Journey.new
	end

	def top_up(amount)
		message = "You cannot exceed the £#{MAXIMUM_LIMIT} limit!"
		raise (message) if max?(amount)
		@balance += amount
	end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise 'Insufficient money on your card!' if min? #haven't touched in current_journey.new? true if current_journey == {}
    @current_journey.start(station)
  end

  def touch_out(station)
    @current_journey.end(station)
    save #if you've touched in and out - current_journey.complete? true if [:entry_station]
    @current_journey.reset
    @balance -= MINIMUM_LIMIT
  end

  def in_journey?
    @current_journey.travelling?
  end

  private

  def save
    @journey_history << @current_journey.current
  end

  def min?
    @balance < MINIMUM_LIMIT
  end

  def max?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end


end

