class Helper
  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp.to_i
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    case type
    when 1
      create_student(name, age)
    when 2
      create_teacher(name, age)
    else
      puts "You haven't enter a right choice!"
    end
    puts 'Person created successfully'
  end

  def create_student(name, age)
    type = 'student'
    print 'Parent permission? [Y/N]: '
    parent_permission = gets.chomp
    if %w[y Y].include?(parent_permission)
      parent_permission = true
    elsif %w[n N].include?(parent_permission)
      parent_permission == false
    end
    APP.create_person(type, age, name, parent_permission)
  end

  def create_teacher(name, age)
    type = 'teacher'
    print 'Specialization: '
    specialization = gets.chomp
    APP.create_person(type, age, name, nil, specialization)
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    APP.create_book(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    APP.display_books
    book = gets.chomp.to_i
    puts 'Select a person from the following list by number(not id)'
    APP.display_people
    person = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp

    book = APP.books[book]
    person = APP.persons[person]

    APP.create_rental(date, person, book)
    puts 'Rental created successfully'
  end

  def display_rentals
    puts 'Id of person: '
    id = gets.chomp.to_i

    our_person = APP.persons.select { |person| person.id == id }.first
    rentals = our_person.rentals

    if rentals.nil?
      puts 'There is no rentals with this ID'
    else
      APP.display_rentals(rentals)
    end
  end
end
