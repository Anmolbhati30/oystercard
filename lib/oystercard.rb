require_relative "journey"

class Oystercard
  BALANCE_LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance, :current_journey

  def initialize(journey = Journey)
    @balance = 0
    @error_messages = {
      valid_amount: "Please provide a valid amount",
      exceed_limit: "Sorry, you cannot exceed the balance limit of £#{BALANCE_LIMIT}",
      insufficient_fare_balance: "Sorry, your balance is not enough to cover the fare",
      insufficient_min_balance: "Sorry, you don't have the minimum balance required of £#{MIN_BALANCE}",
    }
    @current_journey
    @journey = journey
    @journeys = []
    @journey = journey
  end

  def top_up(amount)
    fail @error_messages[:valid_amount] unless valid_amount?(amount)
    fail @error_messages[:exceed_limit] if exceed_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    # fail @error_messages[:in_journey] if in_journey?
    fail @error_messages[:insufficient_min_balance] if fare_exceeds?(@journey::MIN_CHARGE)
    @current_journey = @journey.new(entry_station)
    # @entry_station = entry_station
  end

  def touch_out(exit_station)
    # fail @error_messages[:not_in_journey] unless in_journey?
    finished_journey = @current_journey.finish(exit_station)
    deduct(finished_journey.fare)
    @journeys.push(finished_journey)
    @current_journey = nil

    return finished_journey
  end

  def in_journey?
    !!@current_journey
  end

  def started_at
    @current_journey.entry_station
  end

  def previous_journey
    return @journeys.last
  end

  private

  def deduct(fare)
    fail @error_messages[:insufficient_fare_balance] if fare_exceeds?(fare)
    @balance -= fare
  end

  def valid_amount?(amount)
    (amount.is_a?(Integer) || amount.is_a?(Float)) && (amount.positive?)
  end

  def exceed_limit?(amount)
    @balance + amount > BALANCE_LIMIT
  end

  def fare_exceeds?(fare)
    @balance < fare
  end
end
