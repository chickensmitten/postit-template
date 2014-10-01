class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    #this will associate this comment.post foreign key to this post id. Mass assign the permiteed attribute.
    @comment.creator = User.first #TODO: fix after authentication.

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

end