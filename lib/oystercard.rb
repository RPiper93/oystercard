class Oystercard
  attr_reader :balance
  MAX = 90

  def initialize
    @balance = 0
  end

  def in_journey?
  end

  def top_up(value)
    raise "Maximum balance: #{MAX} reached" if maxed?(value)
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  private

  def maxed?(value)
    @balance + value > MAX
  end

end