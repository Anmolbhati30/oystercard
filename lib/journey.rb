class Journey
  PENALTY_CHARGE = 6
  MIN_CHARGE = 1
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    return self
  end

  def fare
    complete? ? MIN_CHARGE : PENALTY_CHARGE
  end

  def complete?
    @entry_station && @exit_station
  end
end
