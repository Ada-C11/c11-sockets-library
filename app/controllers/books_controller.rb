BOOKS = [
  {title: "Hidden Figures", author: "Margot Lee Shetterly"},
  {title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
  {title: "Kindred", author: "Octavia E. Butler"},
]

class BooksController < ApplicationController
  def index
    # Load a list of books from somewhere
    @books = BOOKS # Book.all
  end
end
