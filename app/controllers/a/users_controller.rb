# frozen_string_literal: true

class A::UsersController < AController
  before_action :set_user, only: %i[show update]

  def index
    @users = User.all
  end

  def show; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to a_user_url(@user),
            notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @user.errors,
            status: :unprocessable_entity
        end
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, roles: [])
  end
end
