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

all_nodes_end = false
while all_nodes_end == false
  puts @steps
  network.instructions.each_char do |instruction|
    new_starting_nodes = []

    all_nodes_end = true
    @starting_nodes.each do |node|
      new_starting_nodes << network.get_next_node(node, instruction)

      all_nodes_end = false unless node.end_node?
    end

    if all_nodes_end
      puts @steps
      break
    end

    @steps += 1
    @starting_nodes = new_starting_nodes
    all_nodes_end = false
  end
end

puts @steps