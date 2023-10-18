# frozen_string_literal: true

class UndergroundSystem
  attr_reader :check_ins, :journey_times

  def initialize
    @check_ins = {}
    @journey_times = Hash.new { |hash, key| hash[key] = [0, 0] }
  end

  def check_in(id, station_name, time)
    @check_ins[id] = [station_name, time]
  end

  def check_out(id, station_name, time)
    start_station, start_time = @check_ins[id]
    @journey_times[[start_station, station_name]][0] += time - start_time
    @journey_times[[start_station, station_name]][1] += 1
  end

  def get_average_time(start_station, end_station)
    total_time, total_trips = @journey_times[[start_station, end_station]]
    # could use BigDecimal here to avoid rounding errors
    result = total_time.to_f / total_trips
    return nil if result.nan?

    result
  end
end
