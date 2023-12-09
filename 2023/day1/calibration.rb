# frozen_string_literal: true

file_path = './day1/lib.txt'
class LineCalibration
  WORD_TO_NUMBER = {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }.freeze
  def initialize(line)
    @line = line
  end

  def get_calibration
    digits_calibration = for_digits
    words_calibration = for_words

    first_value = if digits_calibration[:first_position] == -1
                    words_calibration[:first_value]
                  elsif words_calibration[:first_position] == -1 || digits_calibration[:first_position] < words_calibration[:first_position]
                    digits_calibration[:first_value]
                  else
                    words_calibration[:first_value]
                  end

    last_value = if digits_calibration[:last_position] == -1
                   words_calibration[:last_value]
                 elsif words_calibration[:last_position] == -1 || digits_calibration[:last_position] > words_calibration[:last_position]
                   digits_calibration[:last_value]
                 else
                   words_calibration[:last_value]
                 end


    puts first_value + last_value
    puts (first_value + last_value).to_i
    (first_value + last_value).to_i
  end

  private
  def for_digits
    first_value = nil
    first_position = -1
    last_value = nil
    last_position = -1

    @line.each_char.with_index do |char, index|
      if char.match?(/\d/)
        if first_value.nil?
          first_value = char
          first_position = index
        end

        last_value = char
        last_position = index
      end
    end

    { first_value: first_value, first_position: first_position, last_value: last_value, last_position: last_position}
  end

  def for_words
    first_value = nil
    first_position = -1
    last_value = nil
    last_position = -1

    WORD_TO_NUMBER.each_key do |word|
      first_index = @line.index(word)
      last_index = @line.rindex(word)

      if first_index && (first_position == -1 || first_index < first_position)
        first_value = WORD_TO_NUMBER[word]
        first_position = first_index
      end

      if last_index && (!last_position || last_index > last_position)
        last_value = WORD_TO_NUMBER[word]
        last_position = last_index
      end
    end

    { first_value: first_value, first_position: first_position, last_value: last_value, last_position: last_position}
  end
end


@calibration_values = 0

File.foreach(file_path) do |line|
  @calibration_values += LineCalibration.new(line).get_calibration
end

puts @calibration_values
