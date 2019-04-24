class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    # Load a list of books from somewhere
    if params[:author_id]
      # @books = Book.where(author_id: params[:author_id])

      # - or -

      author = Author.find_by(id: params[:author_id])
      if author
        @books = author.books
      else
        head :not_found
        return
      end
    else
      @books = Book.all
    end

    @featured_book = @books.sample
  end

  def new
    if params[:author_id]
      @author = Author.find_by(id: params[:author_id])
      if @author
        @book = @author.books.new
      else
        head :not_found
        return
      end
    else
      @book = Book.new
    end
  end

  def create
    # Params will contain data like this:
    # "book"=>{"title"=>"Dan Test Book", "author"=>"Test Author"}
    puts "Made it!"

    @book = Book.new(book_params)

    successful = @book.save
    if successful
      flash[:status] = :success
      flash[:message] = "successfully saved a book with ID #{@book.id}"
      redirect_to books_path
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save book"
      render :new, status: :bad_request
    end
  end

  # Show and Edit are entirely the find_books helper
  # def show; end

  # def edit; end

  def update
    # Update includes a save! Don't need to do it ourselves
    if @book.update(book_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated book #{@book.id}"
      redirect_to book_path(@book)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save book #{@book.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    book.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted book #{book.id}"
    redirect_to books_path
  end

  private

  def book_params
    return params.require(:book).permit(:title, :author_id, genre_ids: [])
  end

  def find_book
    @book = Book.find_by(id: params[:id])

    unless @book
      head :not_found
      return
    end
  end
end
