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
end
