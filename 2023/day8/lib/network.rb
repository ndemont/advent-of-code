# Input example
# RL # DIRECTION
#
# AAA = (BBB, CCC) # NODES
# BBB = (DDD, EEE)
# CCC = (ZZZ, GGG)
# DDD = (DDD, DDD)
# EEE = (EEE, EEE)
# GGG = (GGG, GGG)
# ZZZ = (ZZZ, ZZZ)


class Network
  attr_reader :nodes, :instructions
  def initialize
    @nodes = []
    @instructions = ''
  end


  def count_steps(start_node)
    current_node = find_node(start_node)
    steps = 0

    while current_node.value !current_node.end_node?

      instructions.each_char do |instruction|
        steps += 1
        puts "Current node: #{current_node.value}"
        puts "Instruction: #{instruction}"
        puts "Steps: #{steps}"
        current_node = get_next_node(current_node, instruction)
        break if current_node.end_node?
      end
    end

    steps
  end

  def get_next_node(current_node, current_instruction)
    case current_instruction
    when 'L'
      find_node(current_node.left)
    when 'R'
      find_node(current_node.right)
    end
  end

  def add_instruction(instruction)
    @instructions << instruction
  end

  def add_node(node)
    @nodes << node
  end

  def find_node(value)
    @nodes.find { |node| node.value == value }
  end
end
