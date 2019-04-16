class Author < ApplicationRecord
  has_many :books

  def cool_new_method ()
    puts "wow, neat"

    puts "this is a bug"

  end
end
