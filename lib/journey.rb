class Journey

  PENALTY = 6
  MINIMUM_FARE = 1

  def initialize
    @current = {}
  end

  attr_reader :current

  def start(station)
    current[:entry_station] = station
  end

  def end(station)
    current[:exit_station] = station
  end

  def reset
    @current = {}
  end

  def travelling?
    @current != {}
  end

  def fare
   return PENALTY if penalty?
   MINIMUM_FARE
  end

 private

  def penalty?
   @current.size == 1
  end
end