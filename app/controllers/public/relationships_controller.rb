class Public::RelationshipsController < ApplicationController

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