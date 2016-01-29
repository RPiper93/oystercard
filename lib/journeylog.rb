require 'journey.rb'

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
    @journeys << @current_journey
    @current_journey = nil
  end

  private

  attr_reader :journey_klass

end

