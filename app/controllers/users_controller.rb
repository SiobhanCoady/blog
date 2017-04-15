class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged In!'
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
    redirect_to root_path, alert: 'Access denied' unless can? :edit, @user
  end

  def update
    @user = User.find params[:id]
    if !(can? :edit, @user)
      redirect_to root_path, alert: 'Access denied'
    elsif @user.update(user_params)
      redirect_to root_path, notice: 'User Information Updated'
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    @user = User.find current_user.id
    if @user.authenticate(params[:user][:old_password])
      @user.old_password = params[:user][:old_password]
      @user.new_password = params[:user][:new_password]
      # Check that new password is not the same as old password
      if @user.new_password_same_as_old?
        flash[:alert] = 'New password must be different from old password'
        redirect_to edit_password_users_path
      else
        if params[:user][:new_password] == params[:user][:new_password_confirmation]
          @user.password = params[:user][:new_password]
          @user.password_digest
          @user.save
          redirect_to root_path, notice: 'Password Updated'
        else
          flash[:alert] = 'New password does not match new password confirmation'
          redirect_to edit_password_users_path
        end
      end
    else
      flash[:alert] = 'Wrong password entered'
      redirect_to edit_password_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                              :password, :password_confirmation)
  end
end
