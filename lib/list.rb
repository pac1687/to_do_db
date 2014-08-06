class List
  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def name
    @name
  end

  def id
    @id
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do  |result|
      name = result['name']
      id = result['id']
      lists << List.new(name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.remove_list(id)
    DB.exec("DELETE FROM lists WHERE id = #{id};")
    DB.exec("DELETE FROM tasks WHERE list_id = #{id};")


  end

end
