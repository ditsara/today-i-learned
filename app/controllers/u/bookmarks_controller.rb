# frozen_string_literal: true

class U::BookmarksController < UController
  before_action :set_user_content, only: %i[show update destroy]

  def index
    # @bookmarks = current_user.bookmarks.order(created_at: :desc)
    #   .includes(:user_content).page(params[:page])
    @u_posts = UserContent::Post.joins(:bookmarks)
      .where(bookmarks: { user: current_user })
      .order('bookmarks.created_at DESC')
      .with_rich_text_content
      .includes(owner: :avatar_attachment)
      .page(params[:page])
      .with_bookmarks_for(current_user)
  end

  def show; end

  # def create
  #   bm = UserContent::Bookmark.new(user: current_user, **bookmark_params)
  #   user_content = bm.user_content
  #
  #   if bm.save
  #     redirect_to u_post_url(user_content)
  #   else
  #     render :index, status: :unprocessable_entity,
  #       alert: bm.errors.full_messages.join(', ')
  #   end
  # end

  def destroy
    current_user.bookmarks.find_by(user_content: @user_content)&.destroy
    redirect_to u_bookmark_url @user_content
  end

  def update
    existing = current_user.bookmarks.find_by(user_content: @user_content)
    current_user.bookmarks.create(user_content: @user_content) unless existing

    redirect_to u_bookmark_url @user_content
  end

  private

  def set_user_content
    @user_content = UserContent::Post.find(params[:id])
    @user_content.with_bookmark_for(current_user)
  end

  # def bookmark_params
  #   params.require(:user_content_bookmark).permit(:user_content_id)
  # end
end
