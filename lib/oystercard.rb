class Oystercard
  attr_reader :balance
  MAX = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "Maximum balance: #{MAX} reached" if maxed?
    @balance += value
  end

  private

  def maxed?
    @balance >= MAX
  end

end