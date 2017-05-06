class SessionsController < ApplicationController
  def new
  end
  def create
    user = Article.find( params[:session][:title].downcase)

    if user
      flash[:success] = "Welcome to the Sample App!"
      log_in(user)
      redirect_to user
    else
      flash[:danger] = 'invalid email'
      render 'new'
    end
  end
  def destroy

  end
end
