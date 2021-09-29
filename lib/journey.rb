class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_CHARGE = 6
  MIN_CHARGE = 1

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
    { entry: @entry_station, exit: exit_station }
  end

  def fare
    @entry_station && @exit_station ? MIN_CHARGE : PENALTY_CHARGE
  end
end
