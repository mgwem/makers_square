class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.page(params[:page]).order(id: :DESC)
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

end