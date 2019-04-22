require "test_helper"

describe Book do
  before do
    # author = Author.new( {name: "N K Jemisin"} )
    # @book = Book.new(
    #   author: Author.first,
    #   title: "How long 'til black future month?",

    # )
    @book = books(:parable)
  end
  it "must be valid with good data" do
    result = @book.valid?

    expect(result).must_equal true
  end

  it "has genres" do
    book = books(:kindred)
    expect(book.genres.length).must_equal 2

    genre = genres(:fiction)
    expect(genre.books.length).must_equal 1
  end
end
