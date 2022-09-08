require_relative 'nameable'
require_relative 'rental'
require_relative './decorator/capitalize_decorator'
require_relative './decorator/trimmer_decorator'

class Person < Nameable
  attr_accessor :name, :age, :rentals, :parent_permission
  attr_reader :id

  def initialize(id, age, name = 'Unknown', parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    return true if is_of_age?
  end

  def correct_name
    @name
  end

  def add_rentals(date, book)
    rental = Rental.new(date, book, self)
    @rentals << rental
  end
end
