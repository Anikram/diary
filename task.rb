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

    deadline = "Крайний срок: " + @due_date

    return [deadline, @text, time_string]
  end
end