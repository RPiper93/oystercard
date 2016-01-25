class Oystercard
  attr_reader :balance
  MAX = 90

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

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  private

  def maxed?(value)
    @balance + value > MAX
  end

end