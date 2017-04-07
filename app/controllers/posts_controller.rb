class PostsController < ApplicationController
  def index
    @posts = Post.order('id DESC').limit(7)
    @remaining_posts = @posts[1..6]
    @most_recent_post = @posts.first()
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new params.require(:post).permit([:title, :body, :category_id])
    # @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to post_path(@post)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end
end
