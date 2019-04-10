

class BooksController < ApplicationController
  def index
    # Load a list of books from somewhere
    @books = Book.all

    @featured_book = @books.sample
  end

  def new
    @book = Book.new
    # @book.title = "default title"
    # @book.save
  end

  def show
    book_id = params[:id]
    puts "Book ID was #{book_id}"
    puts "Result of .to_i: #{book_id.to_i}"
    # binding.pry

    # does_not_exist

    @book = Book.find_by(id: book_id)

    unless @book
      head :not_found
    end
  end

  # def test
  #   binding.pry
  # end
end
