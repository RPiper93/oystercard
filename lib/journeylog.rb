require_relative 'journey.rb'

class JourneyLog
  def initialize
    @journey_klass = Journey
    @journeys = []
  end

  attr_reader :current_journey, :journeys

  def start_journey(station)
    @current_journey = journey_klass.new(station)
  end

  def exit_journey(station)
    if !@current_journey
      @current_journey = journey_klass.new
    end
    @current_journey.exit_station = station
  end

  def log
    @journeys << display
    @current_journey = nil
  end

  private

  attr_reader :journey_klass

  def display
    "#{entry_station_name} -> #{exit_station_name}"
  end

  def entry_station_name
    return "No Station!" if current_journey.entry_station == nil
    current_journey.entry_station.name
  end

  def exit_station_name
    return "No Station!" if current_journey.exit_station == nil
    current_journey.exit_station.name
  end
end
