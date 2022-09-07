require_relative 'nameable_interface'
require_relative 'rental'
require_relative 'book'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals, :parent_permission

  def initialize(name, age = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    name
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  private

  def of_age?
    age >= 18
  end

  def can_use_services?
    if age >= 18 || parent_permission
      true
    else
      false
    end
  end
end
