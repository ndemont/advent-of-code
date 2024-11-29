@empty_columns = []
@empty_rows = []
@universe = []
@shortest_path_list = []
@all_path_count = 0
@index = 2_000_008
@expansion_coefficient = 1_000_000

def print_universe
  @universe.each { |row| puts row.join(' ') }
  puts ''
end

def parse_file(file_path)
  File.foreach(file_path).with_index do |line, index|
    @universe << line.strip.split('')

    @empty_rows << index unless line.include? '#'
  end
end

def fill_empty_columns
  index = 0
  length = @universe[0].length - 1

  while index < length
    @empty_columns << index unless @universe.any? { |row| row[index] == '#' }
    index += 1

  end
end

def expand_galaxy_rows
  new_universe = []

  @universe.each.with_index do |row, index|
    if @empty_rows.include? index
      @expansion_coefficient.times { new_universe << row }
    else
      new_universe << row
    end
  end

  @universe = new_universe
end

def expand_galaxy_columns
  new_universe = Array.new(@universe.length) { [] }

  @universe.each_with_index do |row, row_index|
    new_row = new_universe[row_index]

    row.each_with_index do |tile, col_index|
      new_row.concat([tile] * @expansion_coefficient) if @empty_columns.include?(col_index)
      new_row << tile unless @empty_columns.include?(col_index)
    end

    @index -= 1
    puts @index if (@index % 10).zero?
  end

  @universe = new_universe
end
def assign_galaxies
  galaxy_number = 1

  @universe.each.with_index do |row, y|
    row.each.with_index do |tile, x|
      if tile == '#'
        @universe[y][x] = galaxy_number
        galaxy_number += 1
      end
    end
  end
end

def count_shortest_path_to_all_galaxies_from(position)
  row_index = position[0]
  column_index = position[1] + 1

  @shortest_path_for_galaxy = []

  while row_index < @universe.length
    while column_index < @universe[0].length
      if @universe[row_index][column_index].is_a? Integer
        shortest_path = (row_index - position[0]).abs + (column_index - position[1]).abs
        @all_path_count += shortest_path
        @shortest_path_for_galaxy << { with_galaxy: @universe[row_index][column_index], path: shortest_path }
      end

      column_index += 1
    end
    column_index = 0
    row_index += 1
  end

  @shortest_path_for_galaxy
end
def count_shortest_path_between_each_galaxy
  @universe.each.with_index do |row, y|
    row.each.with_index do |tile, x|
      @shortest_path_list << count_shortest_path_to_all_galaxies_from([y, x]) if tile.is_a? Integer
    end
  end
end

parse_file('2023/day11/data/example.txt')
fill_empty_columns

print_universe
puts "empty_columns: #{@empty_columns}"
puts "empty_rows: #{@empty_rows}"

expand_galaxy_rows
puts 'galaxy rows expanded'
# print_universe

expand_galaxy_columns
puts 'galaxy columns expanded'
# print_universe

assign_galaxies
puts 'galaxies assigned'
# print_universe

count_shortest_path_between_each_galaxy
# @shortest_path_list.each { |list| puts list.inspect }

puts @all_path_count
