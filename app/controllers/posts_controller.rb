class PostsController < ApplicationController
  before_action :not_logged_in, only: :new
  before_action :not_found, :incorrect_user, only: %i[edit update destroy publish]

  def index
    @posts = Post.all.by_date
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.'}
      else
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was updated."}
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:notice] = 'Post was deleted.'
  end

  def edit
  end
  
  def publish
    @post.published!
    redirect_to post_path(@post)
    flash[:notice] = 'Post was published'
  end
  
  def not_logged_in
    redirect_to log_in_path unless current_user
    flash[:notice] = 'You must be logged in to publish.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :user_id)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found') unless current_user
  end

  def incorrect_user
    @post = Post.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless current_user && current_user == @post.user
  end
end
