class Journey < Struct.new :entry_station, :exit_station
  PENALTY_FARE = 6

  #def in_journey?
  #  !!entry_station
  #end

  def fare
   complete? ? calculate_fare :  PENALTY_FARE
  end

  private

  def complete?
    !!self.entry_station && !!self.exit_station
  end


  def calculate_fare
    (self.entry_station.zone - self.exit_station.zone).abs + 1
  end

end
