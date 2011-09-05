class CommentPostsController < ApplicationController
  
  
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comment_posts.create(params[:comment_post])
    redirect_to post_path(@post)    
  end
  
end
