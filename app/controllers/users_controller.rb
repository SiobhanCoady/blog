class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged In!"
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
    redirect_to root_path, alert: 'Access denied' unless can? :edit, @user
  end

  def update
    # debugger
    @user = User.find params[:id]
    byebug
    if !(can? :edit, @user)
      redirect_to root_path, alert: 'Access denied'
    elsif @user.update(user_params)
      redirect_to root_path, notice: 'User Information Updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                              :password, :password_confirmation)
  end
end
