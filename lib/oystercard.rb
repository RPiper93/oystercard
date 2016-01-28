require_relative 'journey.rb'
=begin
first journey = current journey = [nil, nil]

we need @current_journey
we need @full_history
we need @balance

current journey = [entry, exit]
Journey history = full_history
current journey = journey.history

bad journey1 = [nil exit]
bad journey2 = [entry nil]

Touch in
is current journey?    if !@journey.history[1]
pay fine
add previous journey to full_history
start new journey

Touch out
if !@journey.entry_station
  pay fine
  if !@journey.exit_station
    full_history
  end
  start new journey ["FINE", exit]
  add journey to full_history
=end


class OysterCard
  LIMIT = 50
  MINIMUM = 1
  PENALTY = 6
  attr_reader :balance

  def initialize
    @balance = 0
    @full_history = {}
    #@history = []
    @journey =  Journey.new
  end


  def top_up(value)
    fail "Max reached which is #{LIMIT}" if maximum(value)
    @balance += value
  end

=begin
  Touch in
  is current journey?    if !@journey.history[1]
  pay fine
  add previous journey to full_history
  start new journey
=end

  def touch_in(station)
    fail "Insufficient balance #{MINIMUM}" if minimum
    if !!@journey.entry_station
      p "You didn't check out last time!"
      deduct(PENALTY)
      full_history
      @journey = Journey.new
    end
    @journey.entry_station = station
    time
  end

=begin
  Touch out
  if !@journey.history[0]
    pay fine
    if !@journey.history[1]
      full_history
      @journey = Journey.new
    end
  end
    @journey.history[0] =
=end

  def touch_out(station)
    if !@journey.entry_station #if there is no entry_station in current journey
      deduct(PENALTY)
    end
    deduct(10)
    @journey.exit_station = station
    full_history
    @journey = Journey.new
    end

=begin
    if @history.length != 1
      @journey = Journey.new
    deduct(6)
    end
    deduct(10)
    @journey.exit_station = station
    full_history
    "journey complete" if @journey.complete?
    @journey = Journey.new
  end
=end

  def time
    @time = Time.now
    @journey_time = @time.strftime("Journey date and time: %d/%m/%y  %H:%M:%S")
  end

  def full_history
    @full_history[@journey_time] = @journey.history_log
    @full_history
  end

  def history
    @journey.history_log
  end

  private

  def record_the_journey(record)
    @history << record
  end

  def maximum(value)
    @balance + value > LIMIT
  end

  def minimum
    @balance <= MINIMUM
  end

  def deduct(value)
    @balance -= value
  end
end
