#encoding
#
#

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end #заплатка для работы русского шрифта в Windows

require 'twitter'

class Tweet < Post

@@CLIENT =client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'vDl2Snyyud9EGyFNPoL72xq9u'
  config.consumer_secret = 'wp66ScbcGMBzmW9F4yJ4L70SkCuCxJzYEat235Zmu4XLwE3M6I'
  config.access_token = '169378362-UWvwMno9pCZpSmD3AruSsHpZloxTDGOLwyOM13Mt'
  config.access_token_secret = 'j0I5P0jKoLl0Z4lHNGjoJI9qd24fJotUhgd5oAQomFNOu'
end

  def read_from_console
    puts "Напишите новый твит. (не более 140 символов)"
    @text = STDIN.gets.chomp[0..140].encode("UTF-8")
    puts "Отправляем твит #{@text}"
    @@CLIENT.update(@text)
    puts 'Твит отправлен'
  end

  def to_strings
    time_string = "Созданно в " + @created_at.strftime("%Y.%m.%d, %H:%M:%S") + "\n\r \n\r"
    #puts time_string

    return @text.unshift(time_string)

  end

  def to_db_hash
    return super.merge(
        {
            'text' => @text + '\n\r'
        }
    )
  end

  def load_data(data_hash) # переписываем при помощи полиморфизма - метод экземпляра класса post
    super(data_hash) # обращаемся к родительскому исполнению метода

    @text = data_hash['text'].split('\n\r') #а затем вносим дополнения

  end
end