#   | is a vertical pipe connecting north and south.
#   - is a horizontal pipe connecting east and west.
#   L is a 90-degree bend connecting north and east.
#   J is a 90-degree bend connecting north and west.
#   7 is a 90-degree bend connecting south and west.
#   F is a 90-degree bend connecting south and east.
#   . is ground; there is no pipe in this tile.
#   S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.



@start = [0, 0]
@end = false
@visited_map = []

def can_connect?(direction, next_tile)
  if next_tile == 'S'
    true
  elsif next_tile == '|' && %w[N S].include?(direction)
    true
  elsif next_tile == '-' && %w[E W].include?(direction)
    true
  elsif next_tile == 'L' && %w[S W].include?(direction)
    true
  elsif next_tile == 'J' && %w[S E].include?(direction)
    true
  elsif next_tile == '7' && %w[N E].include?(direction)
    true
  elsif next_tile == 'F' && %w[N W].include?(direction)
    true
  else
    false
  end
end

def fill_surrounding_tile(position, direction)
  up = nil
  down = nil
  left = nil
  right = nil

  # puts "position y: #{position[0]}, x: #{position[1]}"
  # puts "@visited_map y length: #{@visited_map.length}"
  # puts "@visited_map x length: #{@visited_map[0].length}"
  # puts "@visited_map[position[0] - 1][position[1]]: #{@visited_map[position[0] - 1][position[1]]}"

  up = [position[0] - 1, position[1]] if (position[0] - 1 >= 0) && (@visited_map[position[0] - 1][position[1]]) == '0'
  down = [position[0] + 1, position[1]] if (position[0] + 1 < @visited_map.length) && (@visited_map[position[0] + 1][position[1]]) == '0'
  left = [position[0], position[1] - 1] if (position[1] - 1 >= 0) && (@visited_map[position[0]][position[1] - 1]) == '0'
  right = [position[0], position[1] + 1] if (position[1] + 1 < @visited_map[0].length) && (@visited_map[position[0]][position[1] + 1]) == '0'

  case direction
  when 'N'
    @visited_map[left[0]][left[1]] = '>' if left
    @visited_map[right[0]][right[1]] = '<' if right
  when 'S'
    @visited_map[left[0]][left[1]] = '<' if left
    @visited_map[right[0]][right[1]] = '>' if right
  when 'E'
    @visited_map[up[0]][up[1]] = '>' if up
    @visited_map[down[0]][down[1]] = '<' if down
  when 'W'
    @visited_map[up[0]][up[1]] = '<' if up
    @visited_map[down[0]][down[1]] = '>' if down
  end
end
def find_path(map, prev_direction, position, step_count)

  return step_count if @end

  # puts "current position y: #{position[0]}, x: #{position[1]}"
  # puts "current step count: #{step_count}"
  # puts "current tile: #{map[position[0]][position[1]]}"
  # puts "prev_direction: #{prev_direction}\n\n"

  current_tile = map[position[0]][position[1]]
  @visited_map[position[0]][position[1]] = prev_direction

  return 0 if current_tile == '.'

  if current_tile == 'S' && step_count.positive?
    @end = true
    return step_count
  end

  step_count += 1

  north_position = [position[0] - 1, position[1]]
  if current_tile != '-' && current_tile != '7' && current_tile != 'F' && north_position[0] >= 0
    north_tile = map[north_position[0]][north_position[1]]

    if prev_direction != 'S' && can_connect?('N', north_tile)
      fill_surrounding_tile(position, 'N')
      new_step_count = find_path(map, 'N', north_position, step_count)
      return new_step_count if new_step_count.positive?
    end
  end

  south_position = [position[0] + 1, position[1]]
  if current_tile != 'L' && current_tile != 'J' && current_tile != '-' && south_position[0] < map.length
    south_tile = map[south_position[0]][south_position[1]]

    if prev_direction != 'N' && can_connect?('S', south_tile)
      fill_surrounding_tile(position, 'S')
      new_step_count = find_path(map, 'S', south_position, step_count)
      return new_step_count if new_step_count.positive?
    end
  end

  east_position = [position[0], position[1] + 1]
  if current_tile != 'J' && current_tile != '7' && current_tile != '|' && east_position[1] < map[0].length
    east_tile = map[east_position[0]][east_position[1]]

    if prev_direction != 'W' && can_connect?('E', east_tile)
      fill_surrounding_tile(position, 'E')
      new_step_count = find_path(map, 'E', east_position, step_count)
      return new_step_count if new_step_count.positive?
    end
  end

  west_position = [position[0], position[1] - 1]
  if current_tile != 'F' && current_tile != '|' && current_tile != 'L' && west_position[1] >= 0
    west_tile = map[west_position[0]][west_position[1]]

    if prev_direction != 'E' && can_connect?('W', west_tile)
      fill_surrounding_tile(position, 'W')
      new_step_count = find_path(map, 'W', west_position, step_count)
      return new_step_count if new_step_count.positive?
    end
  end

  0
end

def parse_file(file_path)
  map = []
  File.foreach(file_path) do |line|
    @start = [map.length, line.index('S')] if line.include? 'S'
    map << line.strip
  end
  map
end

map = parse_file('2023/day10/data/input.txt')
@visited_map = Array.new(map.length) { Array.new(map[0].length, '0') }
puts "start coordinates y: #{@start[0]}, x: #{@start[1]}"


steps = find_path(map, 'U', @start, 0)

puts steps
puts steps / 2

def check_surrounding_tiles(y, x)
  up = @visited_map[y - 1][x] if y - 1 >= 0
  down = @visited_map[y + 1][x] if y + 1 < @visited_map.length
  left = @visited_map[y][x - 1] if x - 1 >= 0
  right = @visited_map[y][x + 1] if x + 1 < @visited_map[0].length
  
  if up == '<' || down == '<' || left == '<' || right == '<'
    @visited_map[y][x] = '<'
  elsif up == '>' || down == '>' || left == '>' || right == '>'
    @visited_map[y][x] = '>'
  end
end

def check_yourself(y, x)
  up = @visited_map[y - 1][x] if y - 1 >= 0
  down = @visited_map[y + 1][x] if y + 1 < @visited_map.length
  left = @visited_map[y][x - 1] if x - 1 >= 0
  right = @visited_map[y][x + 1] if x + 1 < @visited_map[0].length


  if up == 'W' || down == 'E' || left == 'S' || right == 'N'
    @visited_map[y][x] = '>'
    return true
  elsif up == 'E' || down == 'W' || left == 'N' || right == 'S'
    @visited_map[y][x] = '<'
    return true
  end

  false
end
def fill_left_zeroes
  @visited_map.each_with_index do |row, y|
    row.each_with_index do |_col, x|
      check_surrounding_tiles(y, x) if @visited_map[y][x] == '0'
      check_yourself(y, x) if @visited_map[y][x] == '0'
    end
  end
end

@count_inside = 0
@count_zeros = 0

fill_left_zeroes
@visited_map.each { |row| puts row.join('') }

@visited_map.each_with_index do |row, y|
  row.each_with_index do |_col, x|
    @count_inside += 1 if @visited_map[y][x] == '<'
  end
end

puts @count_inside
