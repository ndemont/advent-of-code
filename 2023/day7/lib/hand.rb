# frozen_string_literal: true

# Represents a hand in a camel card game.
class Hand
  attr_reader :cards, :type, :bid

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
    @all_cards = cards.reject! { |card| card == 'J' }
    @bid = bid
    @type = hand_type
    @jokers = cards.count('J')
  end

  def compare_cards(other_hand)
    cards.each.with_index do |card, index|
      current_label = LABEL[card.to_sym]
      other_label = LABEL[other_hand.cards[index].to_sym]

      next if current_label == other_label

      return current_label < other_label
    end
  end

  private

  def hand_type
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

  def five_of_a_kind?
    if cards.uniq.length == 1
      true
    elsif @jokers == 1 && four_of_a_kind?
      true
    elsif @jokers == 2 && three_of_a_kind?
      true
    elsif @jokers == 3 && one_pair?
      true
    elsif @jokers == 4
      true
    else
      @jokers == 5
    end
  end

  def four_of_a_kind?
    if cards.group_by(&:to_s).any? { |_, group| group.length == 4 }
      true
    elsif @jokers == 1 && three_of_a_kind?
      true
    elsif @jokers == 2 && one_pair?
      true
    elsif @jokers == 3
      true
    else
      @jokers == 4
    end
  end

  def full_house?
    if three_of_a_kind? && one_pair?
      true
    elsif @jokers == 1 && two_pair?
      true
    elsif @jokers == 2 && three_of_a_kind?
      true
    elsif @jokers == 3 && one_pair?
      true
    elsif @jokers == 4
      true
    else
      @jokers == 5
    end
  end

  def two_pair?
    cards.group_by(&:to_s).count { |_, group| group.length == 2 } == 2
  end

  def one_pair?
    cards.group_by(&:to_s).any? { |_, group| group.length == 2 }
  end

  def three_of_a_kind?
    cards.group_by(&:to_s).any? { |_, group| group.length == 3 }
  end
end
