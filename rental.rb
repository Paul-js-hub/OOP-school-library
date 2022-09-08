class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    # @person.rentals.push(self)
    # @book.rentals.push(self)
  end
end
