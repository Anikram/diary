class Link < Post

  def initialize
    super

    @url = ''
  end

  def read_from_console
    puts "Введите аддрес ссылки"
    @url = STDIN.gets.encode("UTF-8").chomp
    puts "Введите комментарий к ссылке"
    @text = STDIN.gets.encode("UTF-8").chomp
  end

  def to_strings

  end
end