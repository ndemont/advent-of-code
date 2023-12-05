FILE_PATH = './day4/input.txt'.freeze

@cards_pile = []
@total_points = 0
@total_cards = 0
def calculate_points(card, current_number)
  if card[:winning_numbers].include?(card[:my_numbers][current_number])
    if @current_points.zero?
      @current_points = 1
    else
      @current_points *= 2
    end
  end

  return unless current_number < card[:my_numbers].size

  calculate_points(card, current_number + 1)
end

def calculate_winning_numbers(card)
  winning_numbers = 0

  card[:winning_numbers].each do |number|
    winning_numbers += 1 if card[:my_numbers].include?(number)
  end

  winning_numbers
end

def parse_file
  File.foreach(FILE_PATH) do |line|
    match = line.match(/Card\s+(\d{1,3}):(.+)\|(.+)/)
    card_number = match[1].to_i
    winning_numbers = match[2].split.map(&:to_i)
    my_numbers = match[3].split.map(&:to_i)

    @cards_pile[card_number] = { my_numbers: my_numbers, winning_numbers: winning_numbers }
  end
end

def count_total_cards(current_card, left_copies)
  new_copies = calculate_winning_numbers(@cards_pile[current_card])

  count_total_cards(current_card + 1, new_copies - 1) if new_copies.positive?
  count_total_cards(current_card + 1, left_copies - 1) if left_copies.positive?

  @total_cards += 1
end

parse_file
puts @cards_pile

@cards_pile.each do |card|
  @current_points = 0
  calculate_points(card, 0) if card
  @total_points += @current_points
end

card_pile_size = @cards_pile.size - 1
puts "card pile size = #{card_pile_size}"
@total_cards = count_total_cards(1, card_pile_size - 1)

puts @total_points
puts @total_cards
