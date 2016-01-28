require_relative 'journey.rb'

class OysterCard
  LIMIT = 50
  MINIMUM = 1
  INITIAL_BALANCE = 30

  attr_reader :balance, :full_history

  def initialize
    @balance = INITIAL_BALANCE
    @full_history = {}
    @journey =  Journey.new
  end

  def top_up(value)
    fail "Max reached which is #{LIMIT}" if maximum(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficient balance #{MINIMUM}" if minimum
    if !!@journey.entry_station
      "You didn't check out last time!"
      end_journey
      create_journey
    end
    add_entry_station(station)
    time
  end

  def touch_out(station)
    time if !@journey.entry_station
    add_exit_station(station)
    end_journey
    create_journey
  end

  def time
    @time = Time.now
    @journey_time = @time.strftime("Journey date and time: %d/%m/%y  %H:%M:%S")
  end

  private

  def fare
    @journey.fare
  end

  def maximum(value)
    @balance + value > LIMIT
  end

  def minimum
    @balance < MINIMUM
  end

  def deduct(value)
    @balance -= value
  end

  def create_journey
    @journey = Journey.new
  end

  def end_journey
    deduct(fare)
    write_history
  end

  def write_history
    @full_history[@journey_time] = @journey.history_log
  end

  def add_entry_station(station)
    @journey.entry_station = station
  end

  def add_exit_station(station)
    @journey.exit_station = station
  end
end
