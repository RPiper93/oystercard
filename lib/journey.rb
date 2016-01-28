class Journey < Struct.new :entry_station, :exit_station, :history
  PENALTY_FARE = 6
  
  def in_journey?
    !!entry_station
  end

  def complete?
    !!self.entry_station && !!self.exit_station
  end

  def fare
   self.complete? ? 10 :  PENALTY_FARE
  end

  def history_log
    self.history = [self.entry_station, self.exit_station]
  end

end
