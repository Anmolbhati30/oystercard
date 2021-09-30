class Journey
  PENALTY_CHARGE = 6
  MIN_CHARGE = 1
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
    # return 0 if start.nil? && @finish.nil?
    @start.nil? ^ @finish.nil? ? PENALTY_CHARGE : MIN_CHARGE
  end


  def create_record
    return { start: @start, finish: @finish }
  end
end
