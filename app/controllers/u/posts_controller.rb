class U::PostsController < UController
  before_action :set_u_post, only: %i[ show edit update destroy ]

  def index
    @u_posts = UserContent::Post.recents.includes(:owner).page(params[:page])
  end

  def hash_tag
    @hash_tag = HashTag.find_by!(name: HashTag.format(params[:id]))
    @u_posts = @hash_tag.user_contents
      .where(type: "UserContent::Post")
      .order(created_at: :desc)
      .includes(:owner)
      .page(params[:page])
    render :index
  end

  # GET /u/posts/1 or /u/posts/1.json
  def show
    @u_replies = @u_post.replies.order(created_at: :asc)
  end

  # GET /u/posts/new
  def new
    @u_post = UserContent::Post.new
  end

  # GET /u/posts/1/edit
  def edit
  end

  # POST /u/posts or /u/posts.json
  def create
    @u_post = UserContent::Post.new(u_post_params)
    @u_post.owner = current_user

    respond_to do |format|
      if @u_post.save
        format.html { redirect_to u_post_url(@u_post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @u_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @u_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /u/posts/1 or /u/posts/1.json
  def update
    respond_to do |format|
      if @u_post.update(u_post_params)
        format.html { redirect_to u_post_url(@u_post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @u_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @u_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /u/posts/1 or /u/posts/1.json
  def destroy
    @u_post.destroy!

    respond_to do |format|
      format.html { redirect_to u_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_u_post
    @u_post = UserContent::Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def u_post_params
    # params.fetch(:u_post, {})
    params.require(:user_content_post).permit(:title, :content)
  end
end
