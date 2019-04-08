require "test_helper"

describe BooksController do
  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get "/books"

      # Assert
      must_respond_with :ok
    end

    it "renders even if there are zero books" do
      skip
      # Arrange
      # TODO get rid of the books
      BooksController::BOOKS.clear
      # Book.destroy_all

      # Act
      get "/books"

      # Assert
      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the book doesn't exist" do
      # TODO come back to this
      book_id = 12345

      get "/books/#{book_id}"

      must_respond_with :not_found
    end

    it "works for a book that exists" do
      # TODO come back to this
      book_id = 0

      get "/books/#{book_id}"

      must_respond_with :ok
    end
  end
end
