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

    @book = Book.new(book_params)

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

  def edit
    book_id = params[:id]

    @book = Book.find_by(id: book_id)

    unless @book
      head :not_found
    end
  end

  def update
    book = Book.find_by(id: params[:id])

    unless book
      head :not_found
      return
    end

    # Update includes a save! Don't need to do it ourselves
    book.update(book_params)

    redirect_to book_path(book)
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

  private

  def book_params
    return params.require(:book).permit(:title, :author)
  end
end
