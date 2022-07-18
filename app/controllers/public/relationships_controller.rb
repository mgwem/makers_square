class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!, except:[:followings, :followers]
  before_action :ensure_active_member, only:[:followings, :followers]

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member.id)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member.id)
  end

  # フォロー一覧
  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings.published_member.page(params[:page]).order("relationships.created_at DESC")
  end

  # フォロワー一覧
  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers.published_member.page(params[:page]).order("relationships.created_at DESC")
  end
end

  private

  # 非公開ユーザー確認
  def ensure_active_member
    @member = Member.find(params[:member_id])
    unless @member.is_deleted == false && @member.is_void == false
      redirect_to root_path
    end
  end