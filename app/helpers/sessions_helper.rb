module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def log_out
    session[:user_id] = nil
    flash[:notice] = "Now you logged out"
    redirect_to login_path
  end

  def require_user
    if !logged_in?
      flash[:notice] = "you must be logged_in?"
      redirect_to root_path
    end
end

end
