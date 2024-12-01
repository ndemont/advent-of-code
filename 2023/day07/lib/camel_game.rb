require_relative 'hand'

# Represents the Camel card game.
class CamelGame
  def initialize(hands)
    @hands = hands
  end

  def count_winnings
    ordered_hands_by_comparison = order_hands_by_comparison

    ordered_hands_by_comparison.each do |hand|
      puts "#{hand.all_cards.join('')} #{hand.bid}, #{hand.regular_type}"
    end

    calculate_winnings(ordered_hands_by_comparison)
  end

  private

  def order_hands_by_comparison
    @hands.sort do |hand1, hand2|
      puts hand1
      puts hand2
      best_type1 = [hand1.regular_type, hand1.joker_type].max
      best_type2 = [hand2.regular_type, hand2.joker_type].max

      if best_type1 > best_type2
        1
      elsif best_type2 > best_type1
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
