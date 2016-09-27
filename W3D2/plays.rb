require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ORM
  attr_reader :sql

  def initialize
    @select = []
    @join = ''
    @where = []
    @args = []
    @group = []
    @having = []
    @limit = ''
    @offset = ''
  end

  def execute(*args)
    PlayDBConnection.instance.execute(*args)
  end

  def method_missing(method, *args, &prc)
    method_name = method.to_s

    if method_name.start_with?('find_by_')
      where(method_name[8..-1], args[0])
      self
    elsif method_name.start_with?('where_')
      where(method_name[6..-1], args[0])
      self
    else
      super
    end
  end

  def get
    data = execute(to_sql, *@args)
    things = []

    data.each do |datum|
      things << self.class.new(datum)
    end

    things
  end

  def to_sql
    sql = "SELECT #{select_to_sql} FROM #{self.class::TABLE} #{@join} "

    sql += where_to_sql

    if @group.length > 0
      sql += "GROUP BY #{@group.join(',')} "

      if @having.length > 0
        sql += "HAVING #{@having.join(' AND ')} "
      end
    end

    sql += "LIMIT #{@limit} " if @limit.length > 0
    sql += "OFFSET #{@offset} " if @offset.length > 0

    sql
  end

  def select_to_sql
    if @select.length > 0
      "#{@select.join(',')}"
    else
      " * "
    end
  end

  def where_to_sql(wheres = nil)
    wheres ||= @where

    str = ''

    wheres.each_with_index do |where, i|
      if where.is_a?(Array)
        str += " (#{where_to_sql(where)}) "
      else
        if i > 0
          connector = where[:connector]
        else
          connector = ''
        end

        str += " #{connector} #{where[:col]} #{where[:comparator]} ? "

        @args << where[:val]
      end
    end

    str.length > 0 ? " WHERE #{str}" : ""
  end

  def where(*args)
    if args.length > 2
      col = args[0]
      comparator = args[1]
      value = args[2]
    else
      col = args[0]
      comparator = '='
      value = args[1]
    end

    @where << {connector: 'AND', col: col, comparator: comparator, val: value}

    self
  end

  def offset(num)
    @offset = num.to_s
    self
  end

  def limit(num)
    @limit = num.to_s
    self
  end

  def self.all
    self.class.new.get
  end

  def insert(options = {})
    sql = <<-SQL
      INSERT INTO
        #{self.class::TABLE} (#{options.keys.join(', ')})
      VALUES
        (#{options.keys.map{'?'}.join(', ')})
    SQL

    execute(sql, *options.values)

    options['id'] = PlayDBConnection.instance.last_insert_row_id
    self.class.new(options)
  end

  def delete
    raise unless @id

    sql = <<-SQL
      DELETE FROM #{self.class::TABLE}
      WHERE id = ?
    SQL

    execute(sql, @id)
  end
end

class Play < ORM
  attr_accessor :title, :year, :playwright_id

  TABLE = 'plays'

  def initialize(options = {})
    if options.length > 0
      @id = options['id']
      @title = options['title']
      @year = options['year']
      @playwright_id = options['playwright_id']
    end
    super()
  end

  def create
    raise "#{self} already in database" if @id
    execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        #{TABLE}
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    data = Play.new.find_by_title(title).get
    return nil if data.empty?
    data.first
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)

    playwright.get_plays
  end
end

class Playwright < ORM
  attr_accessor :name, :birth_year

  TABLE = 'playwrights'

  def self.find_by_name(name)
    data = Playwright.new.find_by_name(name).get
    return nil if data.empty?
    data.first
  end

  def create
    raise "#{self} already in database" if @id
    Playwright.new.insert('name' => @name, 'birth_year' => @birth_year)
  end

  def get_plays
    Play.new.where_playwright_id(@id).get
  end

  def add_play(options)
    options['playwright_id'] = @id
    Play.new(options).create
    get_plays.last
  end

  def update
    raise "#{self} not in database" unless @id
    execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        #{TABLE}
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def initialize(options = {})
    if options.length > 0
      @id = options['id']
      @name = options['name']
      @birth_year = options['birth_year']
    end
    super()
  end
end
