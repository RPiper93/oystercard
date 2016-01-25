class Oystercard
  attr_reader :balance
  MAX = 90
  MIN = 1

  def initialize
    @balance = 0
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  def top_up(value)
    raise "Maximum balance: #{MAX} reached" if maxed?(value)
    @balance += value
  end

  def touch_in
    raise "Under value - Additional fare due" if minimum?
    @travelling = true
  end

  def touch_out
    @travelling = false
    deduct(MIN)
  end

  private

  def maxed?(value)
    @balance + value > MAX
  end

  def minimum?
    @balance < MIN
  end

  def deduct(fare)
    @balance -= fare
  end

end