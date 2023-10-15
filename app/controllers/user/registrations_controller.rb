class User::RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # TODO: show success message
      redirect_to root_path
    else
      # TODO: show errors
      render :new
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
