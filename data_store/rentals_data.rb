require 'json'

module PersistRental
  def store_rentals(rentals)
    rental_array = []
    file = './json_files/rentals.json'
    return unless File.exist?(file)

    rentals.each do |rental|
      rental_array << { date: rental.date, person: rental.person, book: rental.book }
    end
    File.write(file, JSON.generate(rental_array))
  end

  def fetch_rentals
    rental_array = []
    file = './json_files/rentals.json'
    return rental_array unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |rental|
      rental_array << Rental.new(rental['date'], rental[person], rental[book])
    end

    rental_array
  end
end
