require 'json'

module PeopleData
  def store_people(people)
    path = './json_files/person.json'
    people_array = []
    people.each do |person|
      case person
      when Student
        people_array << {name: person.name, age: person.age}
      when Teacher
        people_array << {name: person.name, age:person.age, specialization:person.specialization}
      end
    end
  end
end