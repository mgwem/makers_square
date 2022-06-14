class Public::FavoritesController < ApplicationController

  def index
    @member = Member.find(params[:member_id])
    @favorites = @member.favorites.page(params[:page]).order(id: :DESC)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_member.favorites.new(post_id: @post.id)
    if @favorite.save
      redirect_to member_post_path(@post.member, @post)
    else
      flash[:alert] = "いいねできませんでした"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_member.favorites.find_by(post_id: @post.id)
    if @favorite.destroy
      redirect_to member_post_path(@post.member, @post)
    else
      flash[:alert] = "いいねの削除ができませんでした"
      redirect_back fallback_location: root_path
    end
  end

end
