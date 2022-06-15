class Public::FavoritesController < ApplicationController

  def index
    @member = Member.find(params[:member_id])
    @favorites = @member.favorites.page(params[:page]).order(id: :DESC)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_member.favorites.new(post_id: @post.id)
    @favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_member.favorites.find_by(post_id: @post.id)
    @favorite.destroy
  end

end
