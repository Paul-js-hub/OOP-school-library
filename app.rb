require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative './persist_files/persist_books'
require_relative './persist_files/persist_people'
require_relative './persist_files/persist_rentals'
# rubocop:disable Metrics/ClassLength
class App
  def initialize
    @books = fetch_books
    @people = fetch_people
    @rentals = fetch_rentals
  end

  include BooksPersistence
  include PeoplePersistence
  include RentalsPersistence

  def menu
    puts 'Welcome to OOP SCHOOL LIBRARY SYSTEM!'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def check(options)
    case options
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    end
  end

  def execute
    choice = 0
    while choice != 7
      menu
      puts
      puts
      print '[Enter 1-7]: '
      choice = gets.chomp.strip.to_i
      check(choice)
      puts
      puts
    end
    store_books(@books)
    store_people(@people)
    store_rentals(@rentals)
  end

  def create_book
    puts
    print 'Title: '
    title = gets.chomp.strip.capitalize
    print 'Author: '
    author = gets.chomp.strip.capitalize
    @books.push(Book.new(title, author))
  end

  def list_books
    puts
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def create_person
    puts
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp.strip.to_i
    case choice
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_student
    puts
    print 'Age: '
    age = gets.chomp.strip.to_i
    while age <= 0 || age >= 100
      print 'Please input a valid age: (1 - 100): '
      age = gets.chomp.strip.to_i
    end
    print 'Name: '
    name = gets.chomp.strip.capitalize
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.strip.upcase
    case permission
    when 'Y'
      permission = true
    when 'N'
      permission = false
    end
    @people << Student.new(Random.rand(1..1000), age, nil, name, parent_permission: permission)
    puts 'Person created successfully'
  end

  def create_teacher
    puts
    print 'Age: '
    age = gets.chomp.strip.to_i
    while age <= 0 || age >= 100
      print 'Please input a valid age (1 - 100): '
      age = gets.chomp.strip.to_i
    end
    print 'Name: '
    name = gets.chomp.strip.capitalize
    print 'Specialization: '
    specialization = gets.chomp.strip
    @people << Teacher.new(Random.rand(1..1000), age, specialization, name)
    puts 'Person created successfully'
  end

  def create_rental
    puts
    puts 'Select a book from the following list by number'
    list_books
    book_choice = gets.chomp.to_i
    while book_choice.negative? || book_choice >= @books.length
      print "Please enter a number within 0 - #{@books.length - 1} range: "
      book_choice = gets.chomp.to_i
    end
    # book = @books[book_choice]
    book = "#{@books[book_choice].title} By #{@books[book_choice].author}"
    puts 'Select a person from the following list by number (not id)'
    list_people
    person_choice = gets.chomp.to_i
    while person_choice.negative? || person_choice >= @people.length
      print "Please enter a number within 0 - #{@people.length - 1} range: "
      person_choice = gets.chomp.to_i
    end
    person = @people[person_choice].id
    print 'Enter date of booking: (yyyy/mm/dd) : '
    date = gets.chomp.strip
    # person.add_rentals(date, book)
    @rentals << Rental.new(date, book, person)
  end

  def list_people
    puts
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id} Age: #{person.age}"
    end
  end

  def list_rentals
    puts
    list_people
    print 'ID of person: '
    person_id = gets.chomp.to_i
    # person = get_person(person_id)

    selected_person = @rentals.select { |rental| rental.person == person_id }
    puts 'Rentals:'

    # person.rentals.each do |rental|
    #   puts "Date: #{rental.date} Book: #{rental.book.title} by #{rental.book.author}"
    if selected_person.empty?
      puts "No rentals are found for (#{person_id})"
    else
      selected_person.each do |rental|
        puts "Date: #{rental.date} | Book: #{rental.book}"
      end
    end
  end

  def get_person(id)
    @people.each do |person|
      return person if person.id == id
    end
  end
end
# rubocop:enable Metrics/ClassLength
