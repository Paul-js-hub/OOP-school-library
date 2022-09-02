require_relative 'person'
require_relative 'classroom'
class Student < Person
  attr_reader :classroom

  def initialize(classroom, name, age)
    super(name, age)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
