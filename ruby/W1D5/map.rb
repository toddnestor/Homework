class Map
  def initialize
    @map = []
  end

  def assign(key, value)
    if key_exists?(key)
      update(key, value)
    else
      @map << [key, value]
    end
    [key, value]
  end

  def remove(key)
    @map.delete_if {|item| item[0] == key}
    nil
  end

  def lookup(key)
    @map.each {|item| return item[1] if item[0] == key}
    nil
  end

  def update(key, value)
    @map.each {|item| item[1] = value if item[0] == key}
    value
  end

  def key_exists?(key)
    lookup(key) ? true : false
  end

  def show
    deep_dup(@map)
  end

  private
  def deep_dup(arr)
    new_arr = []
    arr.each {|item| new_arr << (item.is_a?(Array) ? deep_dup(item) : item)}
    new_arr
  end
end

if __FILE__ == $PROGRAM_NAME
  map = Map.new
  map.assign("your mom", "your face")
  map.assign("something", "nothing")
  puts map.lookup("something")
  map.assign("something", "something else")
  map.assign("something2", "something else again")
  map.remove("something2")
  puts map.lookup("something")
  p map.show
end
