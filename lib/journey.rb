class Journey

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

end