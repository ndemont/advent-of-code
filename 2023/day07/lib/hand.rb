# frozen_string_literal: true

# Represents a hand in a camel card game.
class Hand
  attr_reader :cards, :regular_type, :bid, :all_cards, :joker_type

  class CardType
    HIGH_CARD = 0
    ONE_PAIR = 1
    TWO_PAIR = 2
    THREE_OF_A_KIND = 3
    FULL_HOUSE = 4
    FOUR_OF_A_KIND = 5
    FIVE_OF_A_KIND = 6

    def self.to_s(type)
      case type
      when HIGH_CARD
        'High Card'
      when ONE_PAIR
        'One Pair'
      when TWO_PAIR
        'Two Pair'
      when THREE_OF_A_KIND
        'Three of a Kind'
      when FULL_HOUSE
        'Full House'
      when FOUR_OF_A_KIND
        'Four of a Kind'
      when FIVE_OF_A_KIND
        'Five of a Kind'
      else
        'Unknown Type'
      end
    end
  end

  LABEL = {
    'J': 0,
    '2': 1,
    '3': 2,
    '4': 3,
    '5': 4,
    '6': 5,
    '7': 6,
    '8': 7,
    '9': 8,
    'T': 9,
    'Q': 10,
    'K': 11,
    'A': 12
  }.freeze

  def initialize(cards, bid)
    @all_cards = cards
    @regular_cards = cards.reject { |card| card == 'J' }
    @jokers_count = cards.count('J')
    @bid = bid
    @regular_type = regular_hand_type
    @joker_type = joker_hand_type
  end

  def compare_cards(other_hand)
    @all_cards.each.with_index do |card, index|
      current_label = LABEL[card.to_sym]
      other_label = LABEL[other_hand.all_cards[index].to_sym]

      next if current_label == other_label

      return current_label < other_label
    end
  end

  private

  def regular_hand_type
    if five_of_a_kind?
      6
    elsif four_of_a_kind?
      5
    elsif full_house?
      4
    elsif three_of_a_kind?
      3
    elsif two_pair?
      2
    elsif one_pair?
      1
    else
      0
    end
  end

  def joker_hand_type
    if joker_five_of_a_kind?
      CardType::FIVE_OF_A_KIND
    elsif joker_four_of_a_kind?
      CardType::FOUR_OF_A_KIND
    elsif joker_full_house?
      CardType::FULL_HOUSE
    elsif joker_three_of_a_kind?
      CardType::THREE_OF_A_KIND
    elsif joker_two_pair?
      CardType::TWO_PAIR
    elsif joker_one_pair?
      CardType::ONE_PAIR
    else
      CardType::HIGH_CARD
    end
  end

  def joker_five_of_a_kind?
    if @jokers_count == 5 || @jokers_count == 4
      true
    elsif @jokers_count == 3 && @regular_type == CardType::ONE_PAIR
      true
    elsif @jokers_count == 2 && @regular_type == CardType::THREE_OF_A_KIND
      true
    elsif @jokers_count == 1 && @regular_type == CardType::FOUR_OF_A_KIND
      true
    else
      false
    end
  end

  def joker_four_of_a_kind?
    if @jokers_count == 3
      true
    elsif @jokers_count == 2 && @regular_type == CardType::ONE_PAIR
      true
    elsif @jokers_count == 1 && @regular_type == CardType::THREE_OF_A_KIND
      true
    else
      false
    end
  end

  def joker_full_house?
    if @jokers_count == 2 && @regular_type == CardType::ONE_PAIR
      true
    elsif @jokers_count == 1 && @regular_type == CardType::TWO_PAIR
      true
    else
      false
    end
  end

  def joker_three_of_a_kind?
    if @jokers_count == 2
      true
    elsif @jokers_count == 1 && @regular_type == CardType::ONE_PAIR
      true
    else
      false
    end
  end

  def joker_two_pair?
    if @jokers_count == 1 && @regular_type == CardType::ONE_PAIR
      true
    else
      false
    end
  end

  def joker_one_pair?
    if @jokers_count == 1
      true
    else
      false
    end
  end
  def five_of_a_kind?
    @regular_cards.uniq.length == 1
  end

  def three_of_a_kind?
    @regular_cards.group_by(&:to_s).any? { |_, group| group.length == 3 }
  end

  def four_of_a_kind?
    @regular_cards.group_by(&:to_s).any? { |_, group| group.length == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def two_pair?
    @regular_cards.group_by(&:to_s).count { |_, group| group.length == 2 } == 2
  end

  def one_pair?
    @regular_cards.group_by(&:to_s).any? { |_, group| group.length == 2 }
  end
end
