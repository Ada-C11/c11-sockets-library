require "test_helper"

describe Book do
  before do 
    author = Author.new( {name: "N K Jemisin"} )
    @book = Book.new({author: author, title: "How long 'til black future month?", })

  end
  it "must be valid with good data" do
    result = @book.valid?

    expect(result).must_equal true
  end
end
