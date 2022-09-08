require 'json'

module BooksPersistence
  def store_books(books)
    data = []
    file = './JSON_files/books.json'
    return unless File.exist?(file)

    books.each do |book|
      data << { title: book.title, author: book.author }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_books
    data = []
    file = './JSON_files/books.json'
    return [] unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |book|
      data << Book.new(book['title'], book['author'])
    end

    data
  end
end
