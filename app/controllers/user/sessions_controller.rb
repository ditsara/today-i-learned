class User::SessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password])
    if @user
      logger.debug "#{self.class}: Signed in SUCCESS #{@user.email}"
      redirect_back_or_to(root_path, notice: 'Sign in successful')
    else
      logger.debug "#{self.class}: Signed in FAIL #{params[:email]}"
      redirect_to new_user_sessions_path, alert: 'Sign in failed'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Signed out')
  end
end
