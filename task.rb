#encoding: utf-8

require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts "Какая стоит задача?"
    @text = STDIN.gets.chomp

    puts "К какаому числу нужно выполнить задание (дата в формате ДД.ММ.ГГГГ)?"
    date = STDIN.gets.chomp

    @due_date = Date.parse(date)
  end

  def to_strings
    time_string = "Созданно в #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    deadline = "Крайний срок: #{@due_date}"

    return [deadline, @text, time_string]
  end

  def to_db_hash
    return super.merge(
        {
            'text' => @text,
            'due_date' => @due_date.to_s
        }
    )
  end

  def load_data(data_hash) # переписываем при помощи полиморфизма - метод экземпляра класса post
    super(data_hash) # обращаемся к родительскому исполнению метода
    #а затем вносим дополнения
    @due_date = Date.parse(data_hash["due_date"])

  end
end