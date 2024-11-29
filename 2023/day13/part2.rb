# Input:
# #.##..##.
# ..#.##.#.
# ##......#
# ##......#
# ..#.##.#.
# ..##..##.
# #.#.##.#.
# 
# #...##..#
# #....#..#
# ..##..###
# #####.##.
# #####.##.
# ..##..###
# #....#..#

@valley = []

@horizontal_symmetries = []
@perfect_horizontal_symmetries = []

@vertical_symmetries = []
@perfect_vertical_symmetries = []

@pattern_notes_sum = 0

def parse_file(file_path)
  pattern = []
  File.foreach(file_path) do |line|
    if line.strip.empty?
      @valley << pattern
      pattern = []
      next
    end

    pattern << line.strip.split('')
  end
  @valley << pattern
end

def print_valley
  @valley.each do |pattern|
    pattern.each do |row|
      row.each do |col|
        print col
      end
      puts
    end
    puts
  end
end

def find_horizontal_symmetries_with_one_error_margin
  @valley.each.with_index do |pattern, pattern_index|
    row_index = 1
    while row_index < pattern.length
      differences_count = pattern[row_index].zip(pattern[row_index - 1]).count { |a, b| a != b }

      @horizontal_symmetries << { pattern: pattern_index, row: row_index - 1 } if differences_count <= 1
      row_index += 1
    end
  end
end

def find_vertical_symmetries_with_one_error_margin
  @valley.each.with_index do |pattern, pattern_index|
    col_index = 1
    while col_index < pattern[0].length
      row_index = 0

      differences_count = 0
      while row_index < pattern.length
        if pattern[row_index][col_index] != pattern[row_index][col_index - 1]
          differences_count += 1
          break if differences_count > 1
        end
        row_index += 1
      end

      @vertical_symmetries << { pattern: pattern_index, column: col_index - 1} if differences_count <= 1
      col_index += 1
    end
  end
end

def check_perfect_horizontal_symmetry_with_one_error_margin
  @horizontal_symmetries.each do |symmetry|
    pattern = @valley[symmetry[:pattern]]
    row = symmetry[:row]

    row_index = row
    symmetric_row_index = row + 1
    error_margin = 0

    while row_index >= 0 && symmetric_row_index < pattern.length
      if pattern[row_index] && pattern[symmetric_row_index]
        if pattern[row_index] != pattern[symmetric_row_index]
          differences_count = pattern[row_index].zip(pattern[symmetric_row_index]).count { |a, b| a != b }

          error_margin += differences_count
          break if error_margin > 1
        end
      end

      row_index -= 1
      symmetric_row_index += 1
    end

    @perfect_horizontal_symmetries << symmetry if error_margin == 1
  end
end

def check_perfect_vertical_symmetry_with_one_error_margin
  @vertical_symmetries.each do |symmetry|
    pattern = @valley[symmetry[:pattern]]
    column = symmetry[:column]

    column_index = column
    symmetric_column_index = column + 1
    error_margin = 0

    while column_index >= 0 && symmetric_column_index < pattern[0].length
      row_index = 0
      while row_index < pattern.length
        if pattern[row_index][column_index] && pattern[row_index][symmetric_column_index]
          if pattern[row_index][column_index] != pattern[row_index][symmetric_column_index]
            error_margin += 1
            break if error_margin > 1
          end
        end
        
        row_index += 1
      end

      break unless error_margin <= 1

      column_index -= 1
      symmetric_column_index += 1
    end

    @perfect_vertical_symmetries << symmetry if error_margin == 1
  end
end

def summarize_horizontal_pattern_notes
  @perfect_horizontal_symmetries.each do |symmetry|
    @pattern_notes_sum += (symmetry[:row] + 1) * 100
  end
end

def summarize_vertical_pattern_notes
  @perfect_vertical_symmetries.each do |symmetry|
    @pattern_notes_sum += symmetry[:column] + 1
  end
end

parse_file('2023/day13/data/input.txt')
print_valley

find_horizontal_symmetries_with_one_error_margin
puts @horizontal_symmetries.inspect

find_vertical_symmetries_with_one_error_margin
puts @vertical_symmetries.inspect

check_perfect_horizontal_symmetry_with_one_error_margin
puts @perfect_horizontal_symmetries

check_perfect_vertical_symmetry_with_one_error_margin
puts @perfect_vertical_symmetries

summarize_horizontal_pattern_notes
summarize_vertical_pattern_notes
puts @pattern_notes_sum
