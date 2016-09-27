class Node
  attr_reader :value, :parent, :children

  def initialize(value, parent=nil)
    @value = value
    self.parent = parent
    @children = []
  end

  def parent=(node)
    node.children << self unless node.nil? || node.children.include?(self)
    @parent = node
  end

  def trace
    path = []

    node = self
    until node.parent.nil?
      path << node
      node = node.parent
    end

    path.reverse
  end
end
