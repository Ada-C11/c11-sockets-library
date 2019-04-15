class ConnectBooksAndAuthors < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :author, foreign_key: true

    Book.all.each do |book|
      book.author_id = Author.find_by(name: book.author)
      book.save!
    end

    remove_column :books, :author
  end
end
