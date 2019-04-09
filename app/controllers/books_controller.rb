

class BooksController < ApplicationController
  BOOKS = [
    {title: "Hidden Figures", author: "Margot Lee Shetterly"},
    {title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
    {title: "Kindred", author: "Octavia E. Butler"},
  ]

  def index
    # Load a list of books from somewhere
    @books = BOOKS # Book.all

    @featured_book = @books.sample
  end

  def show
    book_id = params[:id]
    puts "Book ID was #{book_id}"
    puts "Result of .to_i: #{book_id.to_i}"
    # binding.pry

    # does_not_exist

    @book = BOOKS[book_id.to_i]
    # @book = Book.find(book_id)

    unless @book
      head :not_found
    end
  end

  # def test
  #   binding.pry
  # end
end
