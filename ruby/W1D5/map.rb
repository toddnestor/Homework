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
  end

  def remove(key)
    @map.delete_if {|item| item[0] == key}
  end

  def lookup(key)
    @map.each {|item| return item[1] if item[0] == key}
    false
  end

  def update(key, value)
    @map.each {|item| item[1] = value if item[0] == key}
    value
  end

  def key_exists?(key)
    lookup(key) ? true : false
  end

  def show
    @map.dup
  end
end

if __FILE__ == $PROGRAM_NAME
  map = Map.new
  map.assign("your mom", "your face")
  map.assign("something", "nothing")
  puts map.lookup("something")
  map.assign("something", "something else")
  puts map.lookup("something")
end
