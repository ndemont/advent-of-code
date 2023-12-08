require_relative 'hand'

# Represents the Camel card game.
class CamelGame
  def initialize(hands)
    @hands = hands
  end

  def count_winnings
    ordered_hands_by_comparison = order_hands_by_comparison

    calculate_winnings(ordered_hands_by_comparison)
  end

  private

  def order_hands_by_comparison
    @hands.sort do |hand1, hand2|
      if hand1.type > hand2.type
        1
      elsif hand2.type > hand1.type
        -1
      elsif hand1.compare_cards(hand2)
        -1
      elsif hand2.compare_cards(hand1)
        1
      else
        0
      end
    end
  end

  def calculate_winnings(ordered_hands)
    sum = 0
    ordered_hands.each.with_index do |hand, index|
      tmp_sum = hand.bid * (index + 1)
      sum += tmp_sum
    end
    sum
  end

end
