#encoding: utf-8

require 'sqlite3'

class Post

  @@SQLITE_DB_FILE = 'diary.sqlite'

  def self.post_types
    {'Memo' => Memo, 'Link' => Link, 'Task' => Task}
  end

  def self.find(limit, type, id) #пишем метод для поиска записей в базе данных
    db = SQLite3::Database.open(@@SQLITE_DB_FILE) #открываем базу данных

    #puts type
    #puts limit
    #puts id

    if !id.nil? # если пользователь указал id записи (id не равно nil), то нужно вывести
      # 1. запись №

      db.results_as_hash = true # не совсем понял что это за метод, но видимо встроенный для BD

      result = db.execute("SELECT * FROM posts WHERE rowid=?", id) # занести в переменную result текст запроса в базу данных для поиска по id

      result = result[0] if result.is_a? Array # защита на случай, если result- не массив

      db.close # база данных уже не нужна - ее можно закрыть

      if result.empty? # проверка результата поиска
        #если рузльтат не найден
        puts "Записи под номером #id = #{id} не найдено."
        return nil
      else
        #если результат найден
        post = create(result['type'])

        post.load_data(result) #to do

        return post
      end
    else
      # 2. вернуть таблицу

      db.results_as_hash = false

      #  сформировать запрос в data base

      query = "SELECT rowid, * FROM posts "

      query += "WHERE type = :type " unless type.nil?

      query += "ORDER by rowid DESC "

      query += "LIMIT :limit" unless limit.nil?

      #puts query - отладка

      begin #конструкция для отлова несоовтетствий
        statement = db.prepare(query)
      rescue SQLite3::SQLException => e
        puts "Не удалось выполнить запрос в базе #{@@SQLITE_DB_FILE}"
        abort e.message
      end

      statement.bind_param('type',type) unless type.nil?
      statement.bind_param('limit',limit) unless limit.nil?

      result = statement.execute!

      statement.close
      db.close

      return result
    end
  end

  def self.create(type)
    return post_types[type].new
  end

  def initialize

    @created_at = Time.now
    @text = nil
  end

  def read_from_console
    #todo
  end

  def to_strings
    #todo
  end

  def save
    file = File.new(file_path, "w")

    to_strings.each {|item| file.puts(item)}

    file.close
  end

  def file_path

    current_path = File.dirname(__FILE__)

    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")

    return current_path + "/" + file_name

  end

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = true

    db.execute(
        "INSERT INTO posts("+
            to_db_hash.keys.join(',') +
            ')' +
            ' VALUES (' +
            ('?,'*to_db_hash.keys.size).chomp(',') +
            ')',
        to_db_hash.values
    )

    insert_row_id = db.last_insert_row_id
    db.close
    return insert_row_id


  end

  def to_db_hash
    {
        'type' => self.class.name,
        'created_at' => @created_at.to_s
    }
  end

  def load_data(data_hash) # задаем общие для всех типов постов параметры
    @created_at = Time.parse(data_hash['created_at'])
    #@text = data_hash['text'].split("\n\r")
  end

end