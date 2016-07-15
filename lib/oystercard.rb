require_relative 'journey'
class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance
  attr_reader :entry_station, :card_journey, :journeys

  # journeys =
  #           [
  #             {entry_station: ["Ealing", 1], exit_station: ["Earls Court", 2]}
  #             {entry_station: ["Ealing", 1, exit_station: ["Earls Court", 2]}
  #           ]

  def initialize
    @balance = 0
    @card_journey = Journey.new
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{MAX_BALANCE}" if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_funds?
    deduct(@card_journey.fare) if !@card_journey.empty_journey?
     @card_journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    @card_journey.finish_journey(exit_station)
    deduct(@card_journey.fare)
    log_journeys(card_journey)
    @card_journey.reset_journey
  end

  def complete?
    @card_journey.complete?
  end

  def log_journeys(card_journey)
    @journeys << card_journey
  end

  private

  def insufficient_funds?
    balance < MIN_BALANCE
  end

  def balance_exceeds_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
