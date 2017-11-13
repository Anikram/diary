#encoding: utf-8
class Link < Post

  def initialize
    super

    @url = ''
  end

  def read_from_console
    puts "Введите аддрес ссылки"
    @url = STDIN.gets.chomp

    puts "Введите комментарий к ссылке"
    @text = STDIN.gets.chomp

  end

  def to_strings
    time_string = "Созданно в #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return [@url, @text, time_string]
  end
end