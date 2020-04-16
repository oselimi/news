class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "Welcome guest"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    log_out
  end
end
