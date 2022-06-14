class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to member_post_path(@post.member, @post)
    else
      flash[:alert] = "コメントを投稿できませんでした"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_back fallback_location: root_path
    else
      flash[:alert] = "コメントを削除できませんでした"
      redirect_back fallback_location: root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
