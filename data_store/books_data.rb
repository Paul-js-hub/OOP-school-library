require 'json'

module BooksData
  def store_books(books)
    books_array = []
    path = './json_files/books.json'
    return unless File.exist?(path)

    books.each do |book|
      books_array << { title: book.title, author: book.author }
    end
    File.write(path, JSON.generate(books_array))
  end

  def fetch_books
    books_array = []
    path = './json_files/books.json'
    return books_array unless File.read(path) != '' && File.exist?(path)

    JSON.parse(File.read(path)).each do |book|
      books_array << Book.new(book['title'], book['author'])
    end
    books_array
  end
end
