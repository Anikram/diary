require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
  puts "Какая стоит задача?"
    @text = STDIN.gets.encode("UTF-8").chomp

    puts "К какаому числу нужно выполнить задание (дата в формате ДД.ММ.ГГГГ)?"
    date = STDIN.gets.encode("UTF-8").chomp

    @due_date = Date.parse(date)
  end

  def to_strings

  end
end