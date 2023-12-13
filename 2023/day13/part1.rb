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

def find_horizontal_symmetries
  @valley.each.with_index do |pattern, pattern_index|
    row_index = 1
    while row_index < pattern.length
      if pattern[row_index] == pattern[row_index - 1]
        @horizontal_symmetries << { pattern: pattern_index, row: row_index - 1 }
      end
      row_index += 1
    end
  end
end

def find_vertical_symmetries
  @valley.each.with_index do |pattern, pattern_index|
    col_index = 1
    while col_index < pattern[0].length
      row_index = 0
      vertical_symmetry = true

      while row_index < pattern.length
        if pattern[row_index][col_index] != pattern[row_index][col_index - 1]
          vertical_symmetry = false
          break
        end
        row_index += 1
      end

      @vertical_symmetries << { pattern: pattern_index, column: col_index - 1} if vertical_symmetry
      col_index += 1
    end
  end
end

def check_perfect_horizontal_symmetry
  @horizontal_symmetries.each do |symmetry|
    pattern = @valley[symmetry[:pattern]]
    row = symmetry[:row]

    row_index = row - 1
    symmetric_row_index = row + 2
    is_perfect = true
    while row_index >= 0 && symmetric_row_index < pattern.length
      if pattern[row_index] && pattern[symmetric_row_index]
        if pattern[row_index] != pattern[symmetric_row_index]
          is_perfect = false
          break
        end
      end

      row_index -= 1
      symmetric_row_index += 1
    end

    @perfect_horizontal_symmetries << symmetry if is_perfect
  end
end

def check_perfect_vertical_symmetry
  @vertical_symmetries.each do |symmetry|
    pattern = @valley[symmetry[:pattern]]
    column = symmetry[:column]

    column_index = column - 1
    symmetric_column_index = column + 2
    is_perfect = true

    while column_index >= 0 && symmetric_column_index < pattern[0].length
      row_index = 0
      while row_index < pattern.length
        if pattern[row_index][column_index] && pattern[row_index][symmetric_column_index]
          if pattern[row_index][column_index] != pattern[row_index][symmetric_column_index]
            is_perfect = false
            break
          end
        end
        
        row_index += 1
      end

      break unless is_perfect

      column_index -= 1
      symmetric_column_index += 1
    end

    @perfect_vertical_symmetries << symmetry if is_perfect
  end
end

def summarize_horizontal_pattern_notes
  @perfect_horizontal_symmetries.each do |symmetry |
    @pattern_notes_sum += (symmetry[:row] + 1) * 100
  end
end

def summarize_vertical_pattern_notes
  @perfect_vertical_symmetries.each do | symmetry |
    @pattern_notes_sum += symmetry[:column] + 1
  end
end

parse_file('2023/day13/data/input.txt')
print_valley

find_horizontal_symmetries
puts @horizontal_symmetries.inspect

find_vertical_symmetries
puts @vertical_symmetries.inspect

check_perfect_horizontal_symmetry
puts @perfect_horizontal_symmetries

check_perfect_vertical_symmetry
puts @perfect_vertical_symmetries

summarize_horizontal_pattern_notes
summarize_vertical_pattern_notes
puts @pattern_notes_sum
