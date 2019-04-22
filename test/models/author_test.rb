require "test_helper"

describe Author do
  describe "validations" do
    before do
      @author = Author.new(
        name: "some unique test name",
      )
    end

    it "passes validations with good data" do
      expect(@author).must_be :valid?
    end

    it "rejects authors with the same name" do
      # arrange
      duplicate_name = Author.first.name
      @author.name = duplicate_name

      # act
      result = @author.valid?

      # assert
      expect(result).must_equal false
      expect(@author.errors.messages).must_include :name
    end
  end

  describe "first_published" do
    it "handles ties somehow" do
    end

    it "does something if the author has no books" do
    end

    it "returns the oldest year" do
    end

    it "can handle books with no pub date" do
    end

    it "can handle B.C.E. books" do
    end
  end
end
