require "test_helper"

describe Author do
  before do
    @author = Author.new(name:"Name Your Author") #auth 1
  end

  it "rejects authors with the same name" do
    #arrange
    Author.create(name: "Name Your Author") #auth 2

    #act
    result = @author.valid?

    expect(result).must_equal false
    expect(@author.errors.messages).must_include :name
  end
end
