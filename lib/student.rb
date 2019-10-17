class Student
  attr_accessor :name, :grade
  attr_reader :id

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      SQL
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
      SQL
    DB[:conn].execute(sql)
  end

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
      SQL
    DB[:conn].execute(sql, name, grade)
    sql = <<-SQL
      SELECT LAST_INSERT_ROWID();
      SQL
    @id = DB[:conn].execute(sql).flatten[0]
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
