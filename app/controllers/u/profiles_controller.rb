class U::ProfilesController < UController
  def show
    @user = current_user
  end
end
