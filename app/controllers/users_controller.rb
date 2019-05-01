class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    auth_hash = request.env["omniauth.auth"]

    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.name}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end

    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    return redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end

  # def login_form
  #   @user = User.new
  # end

  # def login
  #   username = params[:user][:username]

  #   user = User.find_by(username: username)
  #   unless user
  #     # new user
  #     user = User.create(username: username)

  #     # TODO: what if creating the user failed?
  #   end

  #   session[:user_id] = user.id

  #   flash[:status] = :success
  #   flash[:message] = "Successfully logged in as user #{user.username}"

  #   redirect_to root_path
  # end

  # def logout
  #   session[:user_id] = nil

  #   flash[:status] = :success
  #   flash[:message] = "Successfully logged out"

  #   redirect_to root_path
  # end

  def current
    @user = User.find_by(id: session[:user_id])

    unless @user
      flash[:status] = :error
      flash[:message] = "You must be logged in to see this page"
      redirect_to login_path
      return
    end
  end
end
