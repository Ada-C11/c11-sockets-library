module BooksHelper
  def list_books
    full_string = ""
    Book.all.each do |book|
      full_string += "<p> ".html_safe + book.title + "</p>".html_safe
    end

    return full_string.html_safe
  end
end
