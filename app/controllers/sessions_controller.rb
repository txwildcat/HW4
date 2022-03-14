class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where({ email: params["email"] })[0]
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session["user_id"] = @user.id #auth complete has this as :user_id
        flash[:notice] = "Welcome, #{@user.username}."
        redirect_to "/"
      else
        flash[:notice] = "Nope"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Nope"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] "Come back soon!"
    redirect_to "/sessions/new"
  end
end
  