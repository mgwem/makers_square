class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page]).sorted
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
