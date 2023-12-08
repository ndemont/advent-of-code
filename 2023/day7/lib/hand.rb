# frozen_string_literal: true

# Represents a hand in a camel card game.
class Hand
  attr_reader :cards, :type, :bid

  LABEL = {
    '2': 0,
    '3': 1,
    '4': 2,
    '5': 3,
    '6': 4,
    '7': 5,
    '8': 6,
    '9': 7,
    'T': 8,
    'J': 9,
    'Q': 10,
    'K': 11,
    'A': 12
  }.freeze
  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @type = hand_type
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
    cards.uniq.length == 1
  end

  def four_of_a_kind?
    cards.group_by(&:to_s).any? { |_, group| group.length == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
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
