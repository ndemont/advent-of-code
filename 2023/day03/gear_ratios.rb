FILE_PATH = './day3/lib.txt'.freeze

@map = []
@length = 0
@width = 0
@part_number_sum = 0
@gear_sum = 0

def a_symbol?(char)
  !char.match?(/\A\d\z/) && char != '.'
end

def a_numeric?(char)
  return false if char.nil?

  char.match?(/\A\d\z/)
end

def a_gear?(char)
  char == '*'
end

def check_part_number(x, y)
  prev_line = y - 1
  next_line = y + 1
  next_column = x + 1
  prev_column = x - 1

  if @map[prev_line][prev_column] && a_symbol?(@map[prev_line][prev_column])
    true
  elsif @map[prev_line][x] && a_symbol?(@map[prev_line][x])
    true
  elsif @map[prev_line][next_column] && a_symbol?(@map[prev_line][next_column])
    true
  elsif @map[y][prev_column] && a_symbol?(@map[y][prev_column])
    true
  elsif @map[y][next_column] && a_symbol?(@map[y][next_column])
    true
  elsif @map[next_line] && @map[next_line][prev_column] && a_symbol?(@map[next_line][prev_column])
    true
  elsif @map[next_line] && a_symbol?(@map[next_line][x])
    true
  elsif @map[next_line] && @map[next_line][next_column] && a_symbol?(@map[next_line][next_column])
    true
  else
    false
  end
end

def find_part_number
  @map.each.with_index do |line, y|
    x = 0
    while x < line.length
      unless line[x].match?(/\A\d\z/)
        x += 1
        next
      end

      is_part_number = false
      part_number = ''
      while x < line.length
        break unless line[x].match?(/\A\d\z/)

        part_number << line[x]

        is_part_number = true if check_part_number(x, y)
        x += 1
      end
      puts "my final part_number is #{part_number}"
      x += 1
      @part_number_sum += part_number.to_i if is_part_number
    end
  end
end

def check_surrounding_part_numbers(x, y)
  prev_line = y - 1
  next_line = y + 1
  next_column = x + 1
  prev_column = x - 1

  part_numbers = []

  part_numbers << { y: prev_line, x: prev_column } if @map[prev_line][prev_column]&.match?(/\A\d\z/)
  part_numbers << { y: prev_line, x: x } if @map[prev_line][x]&.match?(/\A\d\z/)
  part_numbers << { y: prev_line, x: next_column } if @map[prev_line][next_column]&.match?(/\A\d\z/)
  part_numbers << { y: y, x: prev_column } if @map[y][prev_column]&.match?(/\A\d\z/)
  part_numbers << { y: y, x: next_column } if @map[y][next_column]&.match?(/\A\d\z/)
  part_numbers << { y: next_line, x: prev_column } if @map[next_line] && @map[next_line][prev_column]&.match?(/\A\d\z/)
  part_numbers << { y: next_line, x: x } if @map[next_line] && @map[next_line][x]&.match?(/\A\d\z/)
  part_numbers << { y: next_line, x: next_column } if @map[next_line] && @map[next_line][next_column]&.match?(/\A\d\z/)

  part_numbers
end

def extract_uniq_part_numbers(part_numbers)
  prev_number_x = nil
  prev_number_y = nil
  prev_is_a_duplicate = false

  uniq_part_numbers = []
  part_numbers.each do |number|
    if  (prev_number_y == number[:y] && ((prev_number_x - number[:x]).abs < 2)) || (prev_number_y == number[:y] && prev_is_a_duplicate)
      puts "duplicate number at (#{number[:x]}, #{number[:y]})"
      prev_is_a_duplicate = true
      prev_number_x = number[:x]
      prev_number_y = number[:y]
      next
    end
    puts "current number at (#{number[:x]}, #{number[:y]})"
    prev_is_a_duplicate = false
    uniq_part_numbers << number
    prev_number_x = number[:x]
    prev_number_y = number[:y]
  end
  uniq_part_numbers
end

def find_gears
  uniq_part_numbers = []

  @map.each.with_index do |line, y|
    x = 0
    while x < line.length
      # puts "line[#{x}] = '#{line[x]}'"
      unless a_gear?(line[x])
        x += 1
        next
      end

      puts "we have a potential gear at (#{y}, #{x})"
      part_numbers = check_surrounding_part_numbers(x, y)
      if part_numbers.size > 1
        puts 'we confirm it is a gear!'
        puts "we have part_numbers #{part_numbers}"

        uniq_part_numbers << extract_uniq_part_numbers(part_numbers)
        puts "we have uniq part_numbers #{uniq_part_numbers}"
      end
      x += 1
    end
  end

  uniq_part_numbers.each do |combination|
    next if combination.size < 2

    puts "combination is #{combination}"
    first_number = get_number_values(combination[0])
    second_number = get_number_values(combination[1])

    multiply = first_number.to_i * second_number.to_i

    puts multiply
    @part_number_sum += multiply
  end
end

def get_number_values(number)
  puts "number is #{number}"

  number[:x] -= 1 while number && number[:x] > -1 && a_numeric?(@map[number[:y]][number[:x]])
  number[:x] += 1

  value = ''
  puts "we start at (#{number[:y]},#{number[:x]})"
  while a_numeric?(@map[number[:y]][number[:x]])
    puts "we are at column #{number[:x]}"
    value << @map[number[:y]][number[:x]]
    number[:x] += 1
  end
  puts "final value is #{value}"
  value
end

File.foreach(FILE_PATH).with_index do |line, y|
  @map[y] = []
  line.each_char.with_index do |char, x|
    @width += 1 unless @length
    @map[y][x] = char if char != "\n"
  end
  @length += 1
end

find_gears
# find_part_number
puts @part_number_sum
