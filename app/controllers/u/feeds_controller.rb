class U::FeedsController < ApplicationController
  def recent
    @posts = UserContent::Post.recents
  end
end
