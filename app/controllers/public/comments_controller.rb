class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post.id
    unless @comment.save
      flash[:alert] = "コメントを投稿できませんでした"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    unless @comment.destroy
      flash[:alert] = "コメントを削除できませんでした"
      redirect_back fallback_location: root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
