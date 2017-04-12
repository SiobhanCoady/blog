class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment_params = params.require(:comment).permit(:body)
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment created!'
    else
      render '/posts/show'
    end
  end
end
