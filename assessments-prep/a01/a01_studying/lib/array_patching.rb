require 'byebug'
class Array

  def my_each(&prc)
    length.times do |num|
      prc.call self[num]
    end
  end

  def my_each_with_index(&prc)
    length.times do |num|
      prc.call self[num], num
    end
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
    num > 0 ? drop(num) + take(num) : drop(length + num) + take(length + num)
  end

  def my_join(str = "")

  end

  def my_reverse

  end

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)

  end

  # Write a monkey patch of binary search that accepts a comparison block:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(6) {|el, targ| el+1 <=> targ} => 4
  def my_bsearch(target, &prc)

  end

end
