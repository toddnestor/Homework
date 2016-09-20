class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14)
    place_stones
    @cup_owners = {}
    set_cup_owners(name1,name2)
  end

  def place_stones
    @cups.each_with_index do |_,i|
      @cups[i] = Array.new(4) {:stone} unless is_store_cup?(i)
      @cups[i] = Array.new if is_store_cup?(i)
    end
  end

  def set_cup_owners(name1,name2)
    @cup_owners[name1] = 6
    @cup_owners[name2] = 13
  end

  def is_store_cup?(i)
    [6,13].include?(i)
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless on_board?(start_pos)
  end

  def on_board?(start_pos)
    (1..14).cover?(start_pos)
  end

  def other_players_cup?(name, cup)
    is_store_cup?(cup) && @cup_owners[name] != cup
  end

  def make_move(start_pos, current_player_name)
    pieces = []
    cup = @cups[start_pos]
    pieces << cup.pop until cup.empty?

    cup = start_pos

    pieces.length.times do |i|
      cup = next_cup(cup, current_player_name)
      @cups[cup] << pieces.pop
    end

    render
    next_turn(cup, current_player_name)
  end

  def next_cup(cup, name)
    if is_store_cup?(cup+1) && other_players_cup?(name, cup+1)
      next_index = cup + 2
    else
      next_index = cup + 1
    end

    next_index = 0 unless on_board?(next_index + 1)
    next_index
  end

  def next_turn(ending_cup_idx, name)
    store_cup = @cup_owners[name]
    if @cups[ending_cup_idx].empty?
      return :switch
    elsif ((store_cup-6)..store_cup).cover?(ending_cup_idx)
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
  end

  def winner
  end
end
