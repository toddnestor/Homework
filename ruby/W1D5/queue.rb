class Queue
  def initialize
    @queue = []
  end

  def enqueue(*items)
    items.each {|el| @queue << el}
    items.length == 1 ? items[0] : items
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end
end

if __FILE__ == $PROGRAM_NAME
  queue = Queue.new
  queue.enqueue("something","something else","and whatever")
  puts queue.dequeue
  p queue.show
end
