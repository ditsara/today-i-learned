class U::FeedsController < UController
  def recent
    @posts = UserContent::Post.recents.includes(:owner).page(params[:page])
  end
end
