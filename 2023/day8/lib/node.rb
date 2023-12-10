class Node
  attr_accessor :value, :left, :right

  def initialize(value, left, right)
    @value = value
    @left = left
    @right = right
  end

  def start_node?
    value[2] == 'A'
  end

  def end_node?
    value[2] == 'Z'
  end
end