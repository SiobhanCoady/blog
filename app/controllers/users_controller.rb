require 'securerandom'

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

  def forgot_password
  end

  def reset_password
    @user = User.find_by_email params[:email]
    if @user
      p = PasswordReset.create({ token: generate_token,
                              user_id: @user.id,
                              expires_at: Time.now + 3.days })

      flash[:notice] = 'Email sent with password reset instructions'
      # flash[:notice] = "Reset password at http://localhost:3000/users/user_password_reset?token=#{PasswordReset.last[:token]}"
      redirect_to root_path
    else
      flash.now[:error] = 'Email address not found'
      render :forgot_password
    end
  end

  def user_password_reset
    p = PasswordReset.find_by_token(params[:token])
    if Time.now < p.expires_at
      @token = p.token
    else
      redirect_to forgot_password_users_path, alert: 'Password reset link has expired'
    end
  end

  def new_user_password
    @p = PasswordReset.find_by_token(params[:token])
    @user = User.find @p.user_id
    if params[:new_password] == params[:new_password_confirmation]
      @user.password = params[:new_password]
      @user.password_digest
      @user.save
      redirect_to new_session_path, notice: 'Password Reset'
    else
      flash[:alert] = 'New password does not match new password confirmation'
      redirect_to user_password_reset_users_path(token: params[:token])
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                                :password, :password_confirmation)
    end

    def generate_token
      SecureRandom.hex(13)
    end
end
