class Queue
  def initialize
    @queue = []
  end

  def enqueue(item)
    @queue.unshift(item)
  end

  def dequeue
    @queue.pop
  end

  def empty?
    @queue.empty?
  end
end
