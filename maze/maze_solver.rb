require_relative 'node'
require_relative 'queue'

class MazeSolver
  def initialize(diagonals = false)
    @maze = load_maze(2)
    @path = nil
    @diagonals = diagonals
    solve
  end

  def [](pos)
    row, col = pos
    @maze[row][col]
  end

  def each_row(&prc)
    @maze.each_with_index {|row, i| prc.call(row, i)}
  end

  def each_cell(&prc)
    each_row do |cells, row|
      cells.each_with_index do |cell, col|
        prc.call(cell, [row, col])
      end
    end
  end

  def render
    puts
    each_row do |cell_data, row|
      cell_data.each_with_index do |cell, col|
        pos = [row,col]
        if @path.include?(pos)
          print 'X'
        else
          print cell
        end
      end
      puts
    end
  end

  def solve
    @queue = Queue.new
    seen_cells = [maze_start]

    @queue.enqueue(Node.new(maze_start))

    until @queue.empty?
      cell = @queue.dequeue

      cells = adjacent_positions(cell.value)

      cells.each do |pos|
        new_cell = Node.new(pos, cell)

        if pos == maze_end
          @path = new_cell.trace.map {|node| node.value}
          render
          return
        end

        unless seen_cells.include?(pos)
          @queue.enqueue(new_cell)
          seen_cells.push(pos)
        end
      end
    end

    nil
  end

  private
  def load_maze(name)
    File.readlines("mazes/#{name}.txt").map do |row|
      row.chomp.split('')
    end
  end

  DELTAS = [
    [0,1],
    [0,-1],
    [1,0],
    [-1,0],
  ]

  DIAGONAL_DELTAS = [
    [1,1],
    [1,-1],
    [1,1],
    [-1,1]
  ]

  def adjacent_positions(pos)
    positions = []
    row,col = pos

    diffs = DELTAS + (@diagonals ? DIAGONAL_DELTAS : [])

    DELTAS.each do |diff|
      row_diff, col_diff = diff
      new_pos = [row + row_diff, col + col_diff]
      positions << new_pos if valid_pos?(new_pos)
    end

    positions
  end

  def valid_pos?(pos)
    row,col = pos
    return false if @maze[row].nil?
    return false if @maze[row][col].nil?
    return false if is_wall?(pos)

    true
  end

  def is_wall?(pos)
    self[pos] == '*'
  end

  def maze_start
    each_cell do |cell, pos|
      return pos if cell == 'S'
    end
    nil
  end

  def maze_end
    each_cell do |cell, pos|
      return pos if cell == 'E'
    end
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  maze = MazeSolver.new(false)
end
