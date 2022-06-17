class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]

  def my_page
    @member = current_member
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to members_my_page_path
      flash[:notice] = "ユーザ情報を更新しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @member = current_member
  end

  # 退会処理
  def withdraw
    member = current_member
    member.update(is_deleted: true)
    # 退会した会員が投稿した作品を非表示
    posts = member.posts
    posts.each do |post|
      post.update(is_hidden: true)
    end
    # 退会した会員が投稿したコメントを非表示
    comments = member.comments
    comments.each do |comment|
      comment.update(is_hidden: true)
    end
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.recent.limit(6)
  end

  def posts
    @member = Member.find(params[:id])
    @posts = @member.posts.recent.page(params[:page])
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :website_info, :profile_image)
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guest"
      redirect_to members_my_page_path, notice: "ゲストユーザーはユーザー情報編集画面へ遷移できません"
    end
  end

end
