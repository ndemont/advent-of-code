require_relative 'lib/history'

@histories = []
def parse_file(file_path)
  File.foreach(file_path) do |line|
    history = History.new(line)

    @histories << history
  end
end

def fill_histories
  @histories.each do |history|
    while history.last_line?(history.lines.last) == false
      history.lines << history.create_next_line(history.lines.last)
    end
  end
end

parse_file('2023/day9/data/input.txt')
fill_histories

first_extrapolated_sum = 0
@histories.each do |history|
  history_sum = history.get_last_sequence_sum
  puts "history_sum: #{history_sum}"
  first_extrapolated_sum += history_sum
  puts first_extrapolated_sum
end
puts "\n\n\n\n"

last_extrapolated_sum = 0
@histories.each do |history|
  history_sum = history.get_first_sequence_value
  puts "history_sum: #{history_sum}"
  last_extrapolated_sum += history_sum
  puts last_extrapolated_sum
end




# x 1 3 6 10 15 21
#  x 2 3 4  5  6
#   x 1 1 1  1
#     x 0 0 0
#
# 0
# 1
# 1
# 0
