class Stack
  def initialize
    @stack = []
  end

  def add(*items)
    items.each {|el| @stack << el}
    items.length == 1 ? items[0] : items
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end
end

if __FILE__ == $PROGRAM_NAME
  stack = Stack.new
  stack.add("something","something else","and whatever")
  puts stack.remove
  p stack.show
end
