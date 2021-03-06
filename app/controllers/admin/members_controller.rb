class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)

      # 会員ステータスが変更になった時
      if @member.saved_change_to_is_deleted?
        # 会員ステータスが「退会済み」に変更で作品・コメントを非表示
        if @member.is_deleted == true
          status_change(true)
        # 会員ステータスが「利用中」に変更で作品・コメントを表示
        elsif @member.is_deleted == false && @member.is_void == false
          status_change(false)
        end
      end

      # 管理ステータスが変更になった時
      if @member.saved_change_to_is_void?
        # 管理ステータスが「利用停止」に変更で作品・コメントを非表示
        if @member.is_void == true
          status_change(true)
        # 管理ステータスが「利用可」に変更で作品・コメントを表示
        elsif @member.is_void == false && @member.is_deleted == false
          status_change(false)
        end
      end
      flash[:notice] = "ユーザ情報を更新しました"
      redirect_to admin_member_path(@member)
    else
      flash[:danger] = @member.errors.full_messages
      redirect_to edit_admin_member_path
    end
  end

  def posts
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).order(id: :DESC)
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :website_info, :profile_image, :is_void, :is_deleted)
  end
  
  # 作品・コメントを表示・非表示を変更
  def status_change(status)
    posts = @member.posts
    comments = @member.comments
    posts.each do |post|
      post.update(is_hidden: status)
    end
    comments.each do |comment|
      comment.update(is_hidden: status)
    end
  end

end
