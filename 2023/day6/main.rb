require_relative 'lib/race.rb'
def parse_file(file_path)
  races = []
  time = 0

  File.foreach(file_path) do |line|
    if line.start_with?('Time:')
      rest_of_line = line['Time:'.length..]&.strip
      time = rest_of_line&.delete(' ').to_i
      puts time
    elsif line.start_with?('Distance:')
      rest_of_line = line['Distance:'.length..]&.strip
      distance = rest_of_line&.delete(' ').to_i
      races << Race.new(time, distance)
    end
  end

  races
end

races = parse_file('day6/data/input.txt')
total_possibilities_multiple = 1

races.each do |race|
  puts "The race duration is #{race.time}"
  puts "The race record is #{race.record}"
  puts "The possibilities to beat the record of this race are: #{race.beat_record_possibilities.count}"
  total_possibilities_multiple *= race.beat_record_possibilities.count
end

puts total_possibilities_multiple

