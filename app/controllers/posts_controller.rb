class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    posts = Post.order('id DESC').limit(7)
    @remaining_posts = posts[1..6]
    @most_recent_post = posts.first()
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to post_path(@post)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied" unless can? :edit, @post
  end

  def update
    if !(can? :edit, @post)
      redirect_to root_path, alert: 'Access denied'
    elsif @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post Updated'
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @post
      @post.destroy
      redirect_to posts_path, notice: 'Post deleted'
    else
      redirect_to root_path, alert: 'Access denied'
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit([:title, :body, :category_id])
  end
end
