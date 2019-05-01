class AuthorsController < ApplicationController
  before_action :find_author, except: [:index, :new, :create]

  def index
    do_nada
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: "Author was successfully created."
    else
      render :new
    end
  end

  # def show ; end
  # def edit ; end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: "Author was successfully updated."
    else
      render :new
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_url, notice: "Author was successfully destroyed."
  end

  def do_nada
    return 5
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def author_params
    return params.require(:author).permit(:name)
  end

  def find_author
    @author = Author.find(params[:id])
  end
end
