# frozen_string_literal: true

class U::ProfilesController < UController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.avatar.purge if params[:purge_avatar]

    if @user.update(user_params)
      redirect_to edit_u_profiles_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :about, :avatar, :purge)
  end
end
