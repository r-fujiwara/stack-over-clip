class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #skip_before_action :verify_authenticity_token

  # GET /posts
  # GET /posts.json
  def index
    @resources = current_user.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if Post.shared_post_exist?(@resource.url)
      @shared_users = Post.shared_post_users(@resource.url, current_user.id)
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # GET /posts/:yyyy/:mm/
  def monthly
    target_month = DateTime.new(params[:yyyy].to_i, params[:mm].to_i)
    res1 = current_user.posts.where("updated_at > ?", target_month.beginning_of_month.beginning_of_day)
    res2 = current_user.posts.where("updated_at < ?", target_month.beginning_of_month.end_of_day)
    @resources = res1 & res2
    render 'index'
  end

  # GET /posts/:yyyy/:mm/:dd
  def daily
    target = DateTime.new(params[:yyyy].to_i, params[:mm].to_i, params[:dd].to_i)
    res1 = current_user.posts.where("updated_at > ?", target.beginning_of_day)
    res2 = current_user.posts.where("updated_at < ?", target.end_of_day)
    @resources = res1 & res2
    render 'index'
  end

  # POST /posts
  # POST /posts.json
  def create
    @resource = Post.find_by(user_id: current_user.id, url: params["post"]["url"])
    if @resource.present?
      # refer article recentry or not
      @refer_recently = @resource.created_at > DateTime.now - 7.days
    else
      @resource = Post.create(user_id: current_user.id, url: params["post"]["url"], title: params["post"]["title"])
      @refer_recently = false
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @resource.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def _posts
      @posts ||= current_user.posts
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @resource = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :user_id, :url, :content)
    end

end
