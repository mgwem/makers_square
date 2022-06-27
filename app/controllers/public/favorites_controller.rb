class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!, except:[:index]
  before_action :ensure_active_member, only:[:index]

  def index
    @member = Member.find(params[:member_id])
    @favorites = @member.favorites.page(params[:page]).order(created_at: :DESC)
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

  private

  # 非公開ユーザー確認
  def ensure_active_member
    @member = Member.find(params[:member_id])
    unless @member.is_deleted == false && @member.is_void == false
      redirect_to root_path
    end
  end

end
