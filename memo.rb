class Memo < Post

  def read_from_console
  puts "Новая заметка: Пишите до слова \"end\" (ввести \"end\" в консоль).."

  user_input = nil

  @text = []

    while user_input != "end" do
      line = STDIN.gets.encode("UTF-8").chomp

      @text << line
    end

    @text.pop
  end

  def to_string

  end
end