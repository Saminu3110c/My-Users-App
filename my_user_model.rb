require 'sqlite3'

class User
  DB_FILE = 'db.sql'

  def initialize
    @db = SQLite3::Database.new(DB_FILE)
    create_table
  end

  def create_table
    query = <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
    @db.execute(query)
  end

  def create(user_info)
    @db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", user_info)
    @db.last_insert_row_id
  end

  def find(user_id)
    result = @db.get_first_row("SELECT * FROM users WHERE id = ?", user_id)
    result ? Hash[%w{id firstname lastname age password email}.zip(result)] : nil
  end

  def find_by_email(email)
    result = @db.get_first_row("SELECT * FROM users WHERE email = ?", email)
    result ? Hash[%w{id firstname lastname age password email}.zip(result)] : nil
  end

  def all
    @db.execute("SELECT id, firstname, lastname, age, email FROM users").map do |row|
      Hash[%w{id firstname lastname age email}.zip(row)]
    end
  end

  def update(user_id, attribute, value)
    @db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", value, user_id)
    find(user_id)
  end

  def destroy(user_id)
    @db.execute("DELETE FROM users WHERE id = ?", user_id)
  end
end