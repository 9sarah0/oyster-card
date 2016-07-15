class Journey
  MIN_FARE = 1
  PENTALTY_FARE = 6
  attr_reader :journey, :complete
  def initialize
    @journey = {}
    @complete = false
  end

  def start_journey(entry_station)
    @complete = false
    @journey[:entry_station] = entry_station
  end

  def finish_journey(exit_station)
    @journey[:exit_station] = exit_station
    @complete = true
  end

  def reset_journey
    @journey = {}
  end

  def empty_journey?
    @journey.empty?
  end

  def fare
    return MIN_FARE if @journey[:entry_station] && @journey[:exit_station]
    PENTALTY_FARE
  end

  def complete?
    @complete
  end

end
