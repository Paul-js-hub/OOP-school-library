require_relative 'rental'
require_relative 'teacher'
require_relative 'book'
require_relative 'student'
require_relative 'classroom'
require_relative 'person'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @class = Classroom.new('CS001')
  end

  def get_num(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_by_person_id
    else
      puts 'Please enter a number between 1 and 7'
    end
  end

  def list_all_books
    puts 'There are no books yet! Kindly add books.' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    sleep 0.75
  end

  def list_all_people
    puts 'There are no people yet! Kindly add a student or teacher.' if @people.empty?
    @people.map { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    sleep 0.75
  end

  def create_person
    print 'Do you want to create a student (1) or teacher (2) [Input a number]: '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid input. Kindly type 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase

    student = Student.new(@class, name, age)
    @people << student

    puts 'Student created successfully'
    sleep 0.75
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(specialization, name, age)
    @people << teacher

    puts 'Teacher created successfully'
    sleep 0.75
  end

  def create_book
    puts "Title:"
    title = gets.chomp

    puts "Author:"
    author = gets.chomp

    book = Book.new(title, author)
    @books << book

    puts "Book created successfully"
    sleep 0.75
  end

  def create_rental
    puts "Select a book from the following list by number"

    @books.each_with_index {|book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}"}

    book_number = gets.chomp.to_i
    puts "Select a person from the following list by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_number = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_s

    rental = Rental.new(date, @people[person_number], @books[book_number])
    @rentals << rental

    puts "Rental created successfully"
    sleep 0.75
  end

  def list_rentals_by_person_id
    print "ID of person: "
    id = gets.chomp.to_i

    puts "Rentals: "

    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
    end
    sleep 0.75
  end
end
