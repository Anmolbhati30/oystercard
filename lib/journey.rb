class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station
    @exit_station
  end

  def enter_at(station)
    @entry_station = station
  end

  def exit_at(station)
    @exit_station = station
  end

  def create_record
    @journeys.push({ entry: @entry_station, exit: exit_station })
  end
end
