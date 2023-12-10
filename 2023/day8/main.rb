# frozen_string_literal: true

require_relative 'lib/network'
require_relative 'lib/node'

@starting_nodes = []
@steps = 0
def parse_file(file_path)
  network = Network.new
  File.foreach(file_path).with_index do |line, index|
    next if line.strip.empty?

    if index.zero?
      network.add_instruction(line.strip)
      next
    end

    matches = line.match(/(\w+) = \((\w+), (\w+)\)/)

    root = matches[1]
    left_node = matches[2]
    right_node = matches[3]

    new_node = Node.new(root, left_node, right_node)
    @starting_nodes << new_node if new_node.start_node?

    network.add_node(new_node)
  end

  network
end

network = parse_file('2023/day8/data/input3.txt')

@starting_nodes.each do |initial_node|
  start_node = initial_node

  while start_node.end_node? == false
    network.instructions.each_char do |instruction|
      next_node = network.get_next_node(start_node, instruction)
      initial_node.steps += 1

      start_node = next_node
      break if next_node.end_node?
    end
  end
end

def get_greatest_common_divisor(a, b)
  return a if b.zero?

  get_greatest_common_divisor(b, a % b)
end

def get_least_common_multiple(a, b)
  (a * b) / get_greatest_common_divisor(a, b)
end

array = @starting_nodes.map(&:steps)

@steps = array.reduce { |acc, num|
  get_least_common_multiple(acc, num)
}

puts @steps