require 'byebug'
class Array

  def my_each(&prc)
    length.times do |num|
      prc.call self[num]
    end

    self
  end

  def my_each_with_index(&prc)
    length.times do |num|
      prc.call self[num], num
    end

    self
  end

  def my_select(&prc)
    selected = []
    my_each {|el| selected << el if prc.call(el)}
    selected
  end

  def my_reject(&prc)
    selected = []
    my_each {|el| selected << el unless prc.call(el)}
    selected
  end

  def my_any?(&prc)
    my_each {|el| return true if prc.call(el)}
    false
  end

  def my_all?(&prc)
    my_each {|el| return false unless prc.call(el)}
    true
  end

  def my_flatten
    new_arr = []
    my_each {|el| new_arr += (el.is_a?(Array) ? el.my_flatten : [el])}
    new_arr
  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    return self if n < 1
    new_arr = []
    my_each {|el| new_arr += (el.is_a?(Array) ? el.my_controlled_flatten(n-1) : [el])}
    new_arr
  end

  def my_zip(*arrs)
    arrs.unshift(self)
    arr = Array.new(length) {Array.new(arrs.length)}

    (arrs).my_each_with_index do |el, i|
      el.my_each_with_index do |el2, i2|
        arr[i2][i] = el2 if i2 < length
      end
    end

    arr
  end

  def my_rotate(num=1)
    actual_num = num.abs % length * (num / num.abs)
    num > 0 ? drop(actual_num) + take(actual_num) : drop(length + actual_num) + take(length + actual_num)
  end

  def my_join(str = "")
    reduce {|a,b| a+str+b}
  end

  def my_reverse
    Array.new(length) do |index|
      self[-(index+1)]
    end
  end

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)
    return self if length <=1

    prc ||= Proc.new {|a,b| a <=> b}

    pivot = shift
    left = my_select {|el| prc.call(el, pivot) < 0}
    right = my_select {|el| prc.call(el, pivot) >= 0}

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end

  # Write a monkey patch of binary search that accepts a comparison block:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(6) {|el, targ| el+1 <=> targ} => 4
  def my_bsearch(target, &prc)
    return nil if length < 1
    prc ||= Proc.new {|a,b| a <=> b}
    pivot_index = length/2
    case prc.call self[pivot_index], target
    when -1
      result = drop(pivot_index + 1).my_bsearch(target, &prc)
      return nil unless result
      result + pivot_index + 1
    when 0
      pivot_index
    when 1
      take(pivot_index).my_bsearch(target, &prc)
    end
  end
end
