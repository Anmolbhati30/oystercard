class JourneyLog
  attr_reader :journey_class
  def initialize(journey_class = Journey)
    @journey_class = journey_class

  end
end