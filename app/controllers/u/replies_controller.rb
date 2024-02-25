class U::RepliesController < UController
  before_action :set_u_post

  # GET /u/posts/:id/replies/new
  def new
    @u_reply = @u_post.replies.new
  end

  # GET /u/posts/1/edit
  def edit
    @u_reply = @u_post.replies.find(params[:id])
  end

  # POST /u/posts or /u/posts.json
  def create
    @u_reply = UserContent::Reply.new(u_reply_params)
    @u_reply.assign_attributes owner: current_user, parent: @u_post

    respond_to do |format|
      if @u_reply.save
        format.html { redirect_to u_post_url(@u_post), notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @u_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @u_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /u/posts/1 or /u/posts/1.json
  def update
    authorize @u_post

    respond_to do |format|
      if @u_post.update(u_post_params)
        format.html { redirect_to u_post_url(@u_post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @u_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @u_post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_u_post
    @u_post = UserContent::Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def u_reply_params
    # params.fetch(:u_post, {})
    params.require(:user_content_reply).permit(:title, :content)
  end
end
