require_relative 'nameable_interface'
class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, nameable

  def initialize(name, age = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    super()
  end

  def correct_name
    name
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
