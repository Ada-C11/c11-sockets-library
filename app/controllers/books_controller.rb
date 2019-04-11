class BooksController < ApplicationController
  def index
    # Load a list of books from somewhere
    @books = Book.all

    @featured_book = @books.sample
  end

  def new
    @book = Book.new
  end

  def create
    # Params will contain data like this:
    # "book"=>{"title"=>"Dan Test Book", "author"=>"Test Author"}
    puts "Made it!"

    # TODO: clean this up when we know more
    @book = Book.new

    unless params["book"]
      render :new, status: :bad_request
      return
    end

    @book.title = params["book"]["title"],
    @book.author = params["book"]["author"]

    @book.save

    redirect_to books_path
  end

  def show
    book_id = params[:id]

    @book = Book.find_by(id: book_id)

    unless @book
      head :not_found
    end
  end

  def destroy
    book_id = params[:id]

    book = Book.find_by(id: book_id)

    unless book
      head :not_found
      return
    end

    book.destroy

    redirect_to books_path
  end
end
