# frozen_string_literal: true

require_relative 'lib/camel_game'
require_relative 'lib/hand'

def parse_file(file_path)
  hands = []

  File.foreach(file_path) do |line|
    cards = line.split(' ')[0].split('')
    bid = line.split(' ')[1].to_i

    hands << Hand.new(cards, bid)
  end

  hands
end

hands = parse_file('day7/data/input.txt')
camel_game = CamelGame.new(hands)

puts "Total winnings: #{camel_game.count_winnings}"
