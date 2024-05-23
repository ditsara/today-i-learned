# frozen_string_literal: true

# Represents a Reply. In our tree of UserContent, a Reply node is always
# subordinate to a Post. Note that routes are nested under Posts, so we can
# assume that a Reply will always have a parent Post.
class U::RepliesController < UController
  before_action :set_u_post
  before_action :set_u_reply, only: %i[edit show update]

  # GET /u/posts/:id/replies/new
  def new
    @u_reply = @u_post.replies.new
  end

  # GET /u/posts/:post_id/replies/1/edit
  def edit; end

  # GET /u/posts/:post_id/replies/1
  def show; end

  # POST /u/posts/:post_id/replies
  def create
    @u_reply = UserContent::Reply.new(u_reply_params)
    @u_reply.assign_attributes owner: current_user, parent: @u_post

    respond_to do |format|
      if @u_reply.save
        format.html { redirect_to u_post_url(@u_post), notice: 'Reply was successfully created.' }
        format.turbo_stream
        format.json { render :show, status: :created, location: @u_post }

        @u_reply.broadcast_append_later_to [@u_post, 'replies'],
          partial: 'u/posts/post_detail',
          locals: { post_reply: @u_reply, user: current_user },
          target: [@u_post, 'replies']
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @u_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /u/posts/:post_id/replies/1
  def update
    authorize @u_reply

    respond_to do |format|
      status = @u_reply.update(
        u_reply_params.merge(current_editor_id: current_user.id)
      )
      if status
        format.html { redirect_to u_post_url(@u_post), notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @u_post }

        @u_reply.broadcast_replace_later_to [@u_post, 'replies'],
          partial: 'u/posts/post_detail',
          locals: { post_reply: @u_reply, user: current_user },
          target: @u_reply

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @u_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_u_post
    @u_post = UserContent::Post.find(params[:post_id])
  end

  def set_u_reply
    @u_reply = @u_post.replies.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def u_reply_params
    params.require(:user_content_reply).permit(:title, :content)
  end
end
