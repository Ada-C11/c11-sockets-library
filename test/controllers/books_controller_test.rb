require "test_helper"

describe BooksController do
  before do
    @author = Author.first
    @book = Book.create!(title: "test book", author: @author)
  end
  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get books_path

      # Assert
      must_respond_with :ok
    end

    it "renders even if there are zero books" do
      # Arrange
      Book.destroy_all

      # Act
      get books_path

      # Assert
      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the book doesn't exist" do
      # TODO come back to this
      book_id = 12345

      get book_path(book_id)

      must_respond_with :not_found
    end

    it "works for a book that exists" do
      # Arrange: set up a book
      # See before block above

      # Act: Hey server, can you find the book
      # that we just made
      get book_path(@book.id)

      # Assert
      must_respond_with :ok
    end
  end

  describe "new" do
    it "retruns status code 200" do
      get new_book_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new book" do
      # Arrange
      book_data = {
        book: {
          title: "Create a new book",
          author_id: @author.id,
        },
      }

      # Act
      expect {
        post books_path, params: book_data
      }.must_change "Book.count", +1

      # before_book_count = Book.count
      # post books_path, params: book_data
      # expect(Book.count).must_equal before_book_count + 1

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      check_flash

      book = Book.last
      expect(book.title).must_equal book_data[:book][:title]
      expect(book.author).must_equal @author

      # book_data[:book].keys.each do |key|
      #   expect(book.attributes[key]).must_equal book_data[:book][key]
      # end
    end

    it "sends back bad_request if no book data is sent" do
      book_data = {
        book: {
          title: "",
        },
      }
      expect(Book.new(book_data[:book])).wont_be :valid?

      # Act
      expect {
        post books_path, params: book_data
      }.wont_change "Book.count"

      # Assert
      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "edit" do
    it "responds with OK for a real book" do
      get edit_book_path(@book)
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake book" do
      book_id = Book.last.id + 1
      get edit_book_path(book_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:book_data) {
      {
        book: {
          title: "changed",
        },
      }
    }
    it "changes the data on the model" do
      # Assumptions
      @book.assign_attributes(book_data[:book])
      expect(@book).must_be :valid?
      @book.reload

      # Act
      patch book_path(@book), params: book_data

      # Assert
      must_respond_with :redirect
      must_redirect_to book_path(@book)

      check_flash

      @book.reload
      expect(@book.title).must_equal(book_data[:book][:title])
    end

    it "responds with NOT FOUND for a fake book" do
      book_id = Book.last.id + 1
      patch book_path(book_id), params: book_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      # Arrange
      book_data[:book][:title] = ""

      # Assumptions
      @book.assign_attributes(book_data[:book])
      expect(@book).wont_be :valid?
      @book.reload

      # Act
      patch book_path(@book), params: book_data

      # Assert
      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "destroy" do
    it "removes the book from the database" do
      # Act
      expect {
        delete book_path(@book)
      }.must_change "Book.count", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      check_flash

      after_book = Book.find_by(id: @book.id)
      expect(after_book).must_be_nil
    end

    it "returns a 404 if the book does not exist" do
      # Arrange
      book_id = 123456

      # Assumptions
      expect(Book.find_by(id: book_id)).must_be_nil

      # Act
      expect {
        delete book_path(book_id)
      }.wont_change "Book.count"

      # Assert
      must_respond_with :not_found
    end
  end
end
