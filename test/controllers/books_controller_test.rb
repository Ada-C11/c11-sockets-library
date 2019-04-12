require "test_helper"

describe BooksController do
  describe "index" do
    it "renders without crashing" do
      # Arrange
      Book.create!(title: "test book")

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
      book = Book.create!(title: "test book")

      # Act: Hey server, can you find the book
      # that we just made
      get book_path(book.id)

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
          title: "Test Book",
          author: "Test Author",
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

      book = Book.last
      expect(book.title).must_equal book_data[:book][:title]
      expect(book.author).must_equal book_data[:book][:author]

      # book_data[:book].keys.each do |key|
      #   expect(book.attributes[key]).must_equal book_data[:book][key]
      # end
    end

    it "does something if no book data is sent" do
      # Question: what is "does something", and how do we test for it?
      # Arrange
      book_data = {}

      # Act
      expect {
        post books_path, params: book_data
      }.wont_change "Book.count"

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "update" do
    it "changes the data on the model" do
      # Arrange
      book = Book.create!(title: "original")
      book_data = {
        book: {
          title: "changed",
        },
      }

      # Act
      patch book_path(book), params: book_data

      # Assert
      must_respond_with :redirect
      must_redirect_to book_path(book)

      book.reload
      expect(book.title).must_equal(book_data[:book][:title])
    end
  end

  describe "destroy" do
    it "removes the book from the database" do
      # Arrange
      book = Book.create!(title: "test_book")

      # Act
      expect {
        delete book_path(book)
      }.must_change "Book.size", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      after_book = Book.find_by(id: book.id)
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
