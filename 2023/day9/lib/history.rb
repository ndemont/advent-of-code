class History
  attr_accessor :initial_line, :lines
  def initialize(line)
    @initial_line = parse_line(line)
    @lines = [@initial_line]
  end

  def get_last_sequence_sum
    last_sequence_sum = 0

    index = @lines.length - 2

    prev_number = 0
    while index >= 0
      line = lines[index]

      if line.all?(&:zero?)
        index -= 1
        next
      end

      last_number = line.last
      last_sequence_sum += last_number + prev_number
      index -= 1
    end
    last_sequence_sum
  end


  def get_first_sequence_value
    last_sequence_sum = 0

    index = @lines.length - 2

    while index >= 0
      line = lines[index]

      if line.all?(&:zero?)
        index -= 1
        next
      end

      last_number = line.first
      last_sequence_sum = last_number - last_sequence_sum
      index -= 1
    end
    last_sequence_sum
  end

  def create_next_line(line)
    new_line = []

    index = 0

    while index < line.length - 1
      new_line << line[index + 1] - line[index]
      index += 1
    end

    new_line
  end

  # returns true if line only contains 0s
  def last_line?(line)
    line.all?(&:zero?)
  end

  private

  def parse_line(line)
    line.split(' ').map(&:to_i)
  end
end