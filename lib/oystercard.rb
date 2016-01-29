require_relative 'journeylog.rb'

class OysterCard
  LIMIT = 50
  MINIMUM = 1
  INITIAL_BALANCE = 30

  attr_reader :balance, :log

  def initialize
    @balance = INITIAL_BALANCE
    @log = JourneyLog.new
  end

  def top_up(value)
    fail "Max reached which is #{LIMIT}" if maximum(value)
    @balance += value
  end

  def touch_in(station)
    if !!current
      p "You didn't check out last time!"
      deduct(fare)
      log.log
      p balance
    end
    fail "Insufficient balance #{MINIMUM}" if minimum
    log.start_journey(station)
  end

  def touch_out(station)
    log.exit_journey(station)
    deduct(fare)
    log.log
    p "Your balance is: #{balance}"
  end

  def history
    log.journeys
  end

  private

  def current
    log.current_journey
  end

  def fare
    current.fare
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

end
