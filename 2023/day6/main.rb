
def parse_file(file_path)
  races = []

  File.foreach(file_path) do |line|
    if line.start_with?('Time:')
      time = line.split[1..-1].map(&:to_i)
    elsif line.start_with?('Distance:')
      distance = line.split[1..-1].map(&:to_i)
      distance.each_with_index do |record, index|
        races << Race.new(time[index], record)
      end
    end
  end

  races
end

races = parse_file
puts races.inspect