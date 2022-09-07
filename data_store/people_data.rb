require 'json'

module PeopleData
  def store_people(people)
    people_array = []
    path = './json_files/person.json'
    return unless File.exist?(path)

    people.each do |person|
      case person
      when Student
        people_array << { name: person.name, age: person.age, parent_permission: person.parent_permission }
      when Teacher
        people_array << { name: person.name, age: person.age, specialization: person.specialization }
      end
    end
    File.write(path, JSON.generate(people_array))
  end

  def fetch_people
    persons_array = []
    path = './json_files/person.json'
    return persons_array unless File.exist?(path) && File.read(path) != ''

    JSON.parse(File.read(path)).each do |person|
      persons_array << if person['specialization'].nil?
                         Student.new(person['age'], person['name'], person['parent_permission'])
                       else
                         Teacher.new(person['age'], person['name'], person['specialization'])
                       end
    end

    persons_array
  end
end
