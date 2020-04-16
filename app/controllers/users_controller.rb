class UsersController < ApplicationController
 before_action :set_params, only: [:edit, :update, :show]
 before_action :require_same_user, only: [:edit, :update, :destroy]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to our company"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destory
    @user = User.find(params[:id])
    if @user.destory
      flash[:notice] = "User successfully deleted"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_params
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:notice] = "You are competent just for your profile"
      redirect_to login_path
    end
  end
end
