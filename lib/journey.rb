class Journey
  PENALTY_CHARGE = 6
  attr_reader :start, :finish

<<<<<<< HEAD
  def initialize
    @start
    @finish
  end

  def start_at(station)
    @start = station
  end
  
  def finish_at(station)
    @finish = station
  end

  def fare
    PENALTY_CHARGE
  end


  def create_record
    return { start: @start, finish: @finish }
=======
  PENALTY_CHARGE = 6
  MIN_CHARGE = 1

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
>>>>>>> bf3d88c9a87348a360e7be99d8b85bb475cdcd03
  end
end
