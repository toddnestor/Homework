require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
    duplicated_array = self.dup
    output = accumulator ? accumulator : duplicated_array.shift
    output = yield(output, duplicated_array.shift) until duplicated_array.length < 1
    output
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2..(num ** 0.5).to_i).each {|factor| return false if num % factor == 0 && num != factor} # no need to check above square root
  true
end

def primes(num)
  nums = []
  possible_prime = 2
  until nums.length == num
    nums << possible_prime if is_prime?(possible_prime)
    possible_prime += (possible_prime == 2 ? 1 : 2) # besides 2 no even number is prime, so no need to check them
  end

  nums
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [] if num < 1
  factorials_rec(num-1) + [factorial(num-1)]
end

def factorial(num)
  return 1 if num <= 1
  num * factorial(num-1)
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    duplicates = Hash.new {Array.new}

    self.each_with_index do |el, i|
      duplicates[el] = duplicates[el] << i if self.count(el) > 1
    end

    duplicates
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    substrings = []

    (2..self.length).each do |count|
      self[0..self.length-count].chars.each_with_index do |_, i|
        new_sub = self[i..i + count-1]
        next unless new_sub.length > 2
        substrings << new_sub if new_sub.is_palindrome?
      end
    end

    substrings
  end

  def is_palindrome?
    self.reverse == self
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if self.length <= 1

    first_half = self.take(self.length/2)
    second_half = self.drop(first_half.length)

    Array.merge(first_half.merge_sort(&prc), second_half.merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    return left if right.empty?
    return right if left.empty?

    prc ||= Proc.new {|a,b| a <=> b}

    [(prc.call(left.first, right.first) < 1 ? left.shift : right.shift)] + Array.merge(left, right, &prc)
  end
end
