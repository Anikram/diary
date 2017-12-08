#encoding: utf-8

require_relative 'post.rb'
require_relative 'memo.rb'
require_relative 'link.rb'
require_relative 'task.rb'

#id, limit, type

require 'optparse' # подключение библиотеки для работы парсера опций

options = {}

OptionParser.new do |opt|  # создание парсера для обработки команды -help
  opt.banner = "Usage: read.rb [options]"

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'Какой тип постов показывать (по умолчанию - любой)') {|o| options[:type] =o}
  opt.on('--id POST_ID', 'Если задан ID показывать только этот пост') {|o| options[:id] =o}
  opt.on('--limit NUMBER', 'Ограничить количество выводимых постов (по умолчанию - вывести все)') {|o| options[:limit] =o}
end.parse!

if !options[:id]
  result = Post.find(options[:limit], options[:type])
else
result = Post.find_id(options[:id])

end

if result.is_a? Post
  puts "Запись #{result.class.name}, ID = #{options[:id]}"

  result.to_strings.each do |line|
    puts line
  end
else
  print("| id\t| @type\t|   @created_at\t\t\t| @url\t\t| @due_date \t  ") #шапка без переноса строки

  result.each do |line|
    puts
    line.each do |element|
      print "|  #{element.to_s[0..40]}\t" # не работающая часть кода - .delete("\\n\\r")
    end
  end

end

puts