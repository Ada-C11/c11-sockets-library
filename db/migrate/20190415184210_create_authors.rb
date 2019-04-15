class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name

      t.timestamps
    end

    Book.all.each do |book|
      unless Author.find_by(name: book.author)
        Author.create!(name: book.author)
      end
    end
  end
end
