class Race
  attr_reader :distance, :time

  # the time defines the duration of the race
  # the record defines the best distance achieved recorded for that race in milimeters
  def initialize(time, record)
    @time = time
    @record = record
  end

  # the charging time is the time it takes to charge the battery
  # the time is in milliseconds
  # each additional millisecond of chargin will add 1 millisecond to the speed of the boat
  # if you charge for 1 millicond, the boat will have a speed of 1 millimeter per milisecond
  # if you charge for 2 milliseconds, the boat will have a speed of 2 millimeters per milisecond

  # the beat_record_possibilities method returns an array of all the charging times that will beat the record
  def beat_record_possibilities
    (1..@time).select { |charging_time| beat_record?(charging_time) }
  end

  private

  # the beat_record? method returns true if the boat beats the record taking into account the charging time
  def beat_record?(charging_time)
    time_left = @time - charging_time
    speed = charging_time

    distance = speed * time_left
    distance > @record
  end
end