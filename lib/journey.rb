class Journey
  PENALTY_CHARGE = 6
  attr_reader :start, :finish

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
  end
end
