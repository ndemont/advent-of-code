FILE_PATH = './day2/lib.txt'.freeze
BAG = {'red' => 12, 'green' => 13, 'blue' => 14}

@valid_games_sum = 0
@sum_power = 0
def parse_turns_line(turns_line)
  turns_line.split(';').map do |turn|
    turn.scan(/(\d+) (\w+),?/).map { |count, color| [color, count.to_i] }
  end.flatten(1)
end

def count_cubes
  File.foreach(FILE_PATH) do |line|
    puts line

    game_number = nil
    line.sub!(/Game (\d+):/) do
      game_number = Regexp.last_match(1).to_i
      ''
    end
    
    max = { 'red' => 0, 'green' => 0, 'blue' => 0 }

    turns = parse_turns_line(line)

    puts "TURNS #{turns}"

    valid = true

    puts 'Parsed Turns:'
    turns.each do |color, count|
      max[color] = count if count > max[color]

      puts "  #{count} #{color}"

      # if BAG[color.to_s] < count
      #   valid = false
      #   break
      # end
    end

    puts "Game #{game_number} max red: #{max['red']},  green: #{max['green']},  blue: #{max['blue']},"

    @sum_power += (max['red'] * max['green'] * max['blue'])
    @valid_games_sum += game_number if valid
  end
end

count_cubes
puts @valid_games_sum
puts @sum_power
