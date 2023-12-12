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


def find_path(map, prev_direction, start_position, max_steps)
  stack = []
  stack.push([start_position, 1, prev_direction])  # [position, step_count, prev_direction]

  while !stack.empty?
    position, step_count, prev_direction = stack.pop
    y, x = position

    @visited_map[y][x] = step_count

    if step_count == max_steps
      @visited_map.each { |row| puts row.join(' ') }
      return step_count
    end

    current_tile = map[y][x]

    return 0 if current_tile == '.'

    if current_tile == 'S' && step_count.positive?
      @end = true
      return step_count
    end

    step_count += 1

    neighbors = [
      [[y - 1, x], 'N'],
      [[y + 1, x], 'S'],
      [[y, x + 1], 'E'],
      [[y, x - 1], 'W']
    ]

    neighbors.each do |neighbor_pos, direction|
      ny, nx = neighbor_pos

      next if ny < 0 || ny >= map.length || nx < 0 || nx >= map[0].length

      neighbor_tile = map[ny][nx]

      if prev_direction != opposite_direction(direction) && can_connect?(direction, neighbor_tile)
        stack.push([neighbor_pos, step_count, direction])
      end
    end
  end

  0
end

def opposite_direction(direction)
  case direction
  when 'N' then 'S'
  when 'S' then 'N'
  when 'E' then 'W'
  when 'W' then 'E'
  end
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
@visited_map = Array.new(map.length) { Array.new(map[0].length, 0) }
puts "start coordinates y: #{@start[0]}, x: #{@start[1]}"


steps = find_path(map, 'U', @start, 0)
@visited_map.each { |row| puts row.join(' ') }

puts steps
puts steps / 2