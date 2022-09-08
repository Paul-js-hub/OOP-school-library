require 'json'

module RentalsPersistence
  def store_rentals(rentals)
    data = []
    file = './JSON_files/rentals.json'
    return unless File.exist?(file)

    rentals.each do |rental|
      data << { date: rental.date, book: rental.book, person: rental.person }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_rentals
    data = []
    file = './JSON_files/rentals.json'
    return [] unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |rental|
      data << Rental.new(rental['date'], rental['book'], rental['person'])
    end

    data
  end
end
