require_relative 'app'
require_relative 'data_store/books_data'
require_relative 'data_store/people_data'
class Main < App
include BooksData
include PeopleData
  def run
    puts 'Welcome to School Library!'
    loop do
      menu
      option = gets.chomp
      break if option == '7'

      get_num option
    end
    store_books(@books)
    store_people(@people)
    puts 'Thank you for using our Library!'
  end

  def menu
    puts
    puts 'Please choose an option by entering a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end
end

Main.new.run
