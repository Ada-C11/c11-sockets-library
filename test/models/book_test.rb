require "test_helper"

describe Book do
  let(:book) { Book.new }

  it "must be valid" do
    skip
    value(book).must_be :valid?
  end
end
