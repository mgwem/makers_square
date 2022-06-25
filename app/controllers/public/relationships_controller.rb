class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!, except:[:followings, :followers]
  before_action :ensure_active_member, only:[:followings, :followers]

  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings.recent_member.page(params[:page])
  end

  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers.recent_member.page(params[:page])
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