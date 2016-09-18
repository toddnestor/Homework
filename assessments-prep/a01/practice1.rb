class Array
  def merge_sort
    return self if self.length <= 1

    left = self.take(self.length/2)
    right = self.drop(left.length)

    Array.merge(left.merge_sort, right.merge_sort)
  end

  def self.merge(left, right)
    return left if right.empty?
    return right if left.empty?

    [Array.first_merge_item(left,right)] + Array.merge(left, right)
  end

  def self.first_merge_item(left, right)
    left.first < right.first ? left.shift : right.shift
  end

  def quick_sort
    return self if self.length <= 1

    pivot = self.shift
    left = select {|item| item < pivot}
    right = select {|item| item >= pivot}

    left.quick_sort + [pivot] + right.quick_sort
  end
end
