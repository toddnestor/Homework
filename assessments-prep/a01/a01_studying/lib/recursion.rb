class Node
  attr_accessor :parent, :children, :value

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def path
    node = self
    lineage = []

    return lineage if node.parent.nil?

    until node.nil?
      lineage.unshift(node)
      node = node.parent
    end

    lineage
  end
end

class RecursionMachine

  # Implement a method that finds the sum of the first n
  # fibonacci numbers recursively. Assume n > 0
  def fibs_sum(n)
    return 1 if n == 1
    fibonacci(n) + (n > 1 ? fibs_sum(n-1) : 0)
  end

  def fibonacci(n)
    return 1 if n <= 2
    fibonacci(n-1) + fibonacci(n-2)
  end

  #returns all subsets of an array
  def subsets(array)
    return [[]] if array.length < 1
    subs = subsets(array.take(array.length - 1))
    subs.concat(subs.map {|el| el + [array.last]})
  end

  # return the sum of the first n even numbers recursively. Assume n > 0
  def first_even_numbers_sum(n)
    return 2 if n == 1
    first_even_numbers_sum(n-1) + (n*2)
  end

  # return b^n recursively. Your solution should accept negative values
  # for n
  def exponent(b, n)
    return 1 if n == 0

    if n > 0
      b * exponent(b, n-1)
    else
      b = b.to_f
      exponent(b, n+1) / b
    end
  end

  # make better change problem from class
  def make_better_change_dpf(value, coins)
    coins_to_check = coins.select {|el| el <= value}
    return nil if coins_to_check.empty?

    solutions = []

    coins_to_check.sort.reverse.each do |coin|
      remainder = value - coin

      if remainder > 0
        remainder_solution = make_better_change(remainder, coins_to_check)
        solutions << [coin] + remainder_solution unless remainder_solution.nil?
      else
        solutions << [coin]
      end
    end

    solutions.sort_by! {|solution| solution.size}.first.sort.reverse
  end

  def make_better_change(value, coins)
    coins_to_check = coins.select {|el| el <= value}.sort.reverse
    return nil if coins_to_check.empty?

    queue = [Node.new(value)]
    final_node = nil

    until queue.empty? || final_node
      anchor = queue.shift

      coins.each do |coin|
        node = Node.new(anchor.value - coin, anchor)
        final_node = node if node.value == 0
        queue << node
      end
    end

    return nil if final_node.nil?

    final_node.path.drop(1).map do |node|
      node.parent.value - node.value
    end
  end

  #deep dup question from class
  def deep_dup(arr)
    arr.map {|el| el.is_a?(Array) ? deep_dup(el) : el}
  end

  # Write a recursive method that takes in a string to search and a key string.
  # Return true if the string contains all of the characters in the key
  # in the same order that they appear in the key.
  #
  # string_include_key?("cadbpc", "abc") => true
  # string_include_key("cba", "abc") => false
  def string_include_key?(string, key)
    
  end

  # Write a recursive function that returns the prime factorization of
  # a given number. Assume num > 1
  #
  # prime_factorization(12) => [2,2,3]
  def prime_factorization(num)

  end

  # Write a method, `digital_root(num)`. It should Sum the digits of a positive
  # integer. If it is greater than 10, sum the digits of the resulting number.
  # Keep repeating until there is only one digit in the result, called the
  # "digital root". **Do not use string conversion within your method.**
  #
  # You may wish to use a helper function, `digital_root_step(num)` which performs
  # one step of the process.

  def digital_root(num)

  end

  # Write a recursive method that takes in a base 10 number n and
  # converts it to a base b number. Return the new number as a string
  #
  # E.g. base_converter(5, 2) == "101"
  # base_converter(31, 16) == "1f"

  def base_converter(num, b)

  end

  # CHALLENGE: Eight queens puzzle precursor
  #
  # Write a recursive method that generates all 8! possible unique ways to
  # place eight queens on a chess board such that no two queens are in
  # the same board row or column (the same diagonal is OK).
  #
  # Each of the 8! elements in the return array should be an array of positions:
  # E.g. [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
  #
  # My solution used 3 method parameters: current_row, taken_columns, and
  # positions so far
  def eight_queens_possibilities(current_row, taken_columns, positions)

  end

end
