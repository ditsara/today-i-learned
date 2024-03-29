# frozen_string_literal: true

class User::PasswordResetsController < PubController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])

    # send an email to the user with instructions on how to reset their password
    # (a url with a random token)
    @user&.deliver_reset_password_instructions!

    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in
    # the system.
    redirect_to(root_path, notice: 'Instructions have been sent to your email.')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    # rubocop:disable Style/GuardClause
    if @user.blank?
      not_authenticated
      nil
    end
    # rubocop:enable Style/GuardClause
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # makes the password confirmation validation work
    @user.password_confirmation = params[:password_confirmation]

    # clears the temporary token and updates the password
    if @user.change_password(params[:password])
      redirect_to(root_path, notice: 'Password was successfully updated.')
    else
      render action: 'edit'
    end
  end
end
