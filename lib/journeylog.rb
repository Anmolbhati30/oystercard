class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey
    @journeys = []
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def finish(exit_station)
    @journeys.push(@current_journey.finish(exit_station))
    return @journeys.last.fare
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
