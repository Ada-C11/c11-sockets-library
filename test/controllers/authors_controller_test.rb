require "test_helper"

describe AuthorsController do
  let(:author) { authors :one }

  it "gets index" do
    get authors_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_author_url
    value(response).must_be :success?
  end

  it "creates author" do
    expect {
      post authors_url, params: { author: {  } }
    }.must_change "Author.count"

    must_redirect_to author_path(Author.last)
  end

  it "shows author" do
    get author_url(author)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_author_url(author)
    value(response).must_be :success?
  end

  it "updates author" do
    patch author_url(author), params: { author: {  } }
    must_redirect_to author_path(author)
  end

  it "destroys author" do
    expect {
      delete author_url(author)
    }.must_change "Author.count", -1

    must_redirect_to authors_path
  end
end
