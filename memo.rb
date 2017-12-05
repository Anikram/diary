# encoding: utf-8
class Memo < Post

  def read_from_console
    puts "Новая заметка: Пишите до слова \"end\" (ввести \"end\" в консоль).."
    @text = []
    line = nil


    while line != "end" do
      line = STDIN.gets.encode("UTF-8").chomp

      @text << line
    end

    @text.pop
  end

  def to_strings
     time_string = "Созданно в " + @created_at.strftime("%Y.%m.%d, %H:%M:%S") + "\n\r \n\r"
    #puts time_string

    return @text.unshift(time_string)

  end

  def to_db_hash
    return super.merge(
        {
            'text' => @text.join('\n\r')
        }
    )
  end

  def load_data(data_hash) # переписываем при помощи полиморфизма - метод экземпляра класса post
    super(data_hash) # обращаемся к родительскому исполнению метода

    @text = data_hash['text'].split('\n\r') #а затем вносим дополнения

  end
end