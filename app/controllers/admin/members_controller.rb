class Admin::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      posts = @member.posts
      comments = @member.comments

      # 会員ステータスが変更になった時
      if @member.saved_change_to_is_deleted?
        # 会員ステータスが「退会済み」に変更で作品・コメントを非表示
        if @member.is_deleted == true
          posts.each do |post|
            post.update(is_hidden: true)
          end
          comments.each do |comment|
            comment.update(is_hidden: true)
          end
        # 会員ステータスが「利用中」に変更で作品・コメントを表示
        elsif @member.is_deleted == false && @member.is_void == false
          posts.each do |post|
            post.update(is_hidden: false)
          end
          comments.each do |comment|
            comment.update(is_hidden: false)
          end
        end
      end

      # 管理ステータスが変更になった時
      if @member.saved_change_to_is_void?
        # 管理ステータスが「無効」に変更で作品・コメントを非表示
        if @member.is_void == true
          posts.each do |post|
            post.update(is_hidden: true)
          end
          comments.each do |comment|
            comment.update(is_hidden: true)
          end
        # 管理ステータスが「有効」に変更で作品・コメントを表示
        elsif @member.is_void == false && @member.is_deleted == false
          posts.each do |post|
            post.update(is_hidden: false)
          end
          comments.each do |comment|
            comment.update(is_hidden: false)
          end
        end
      end
      flash[:notice] = "ユーザ情報を更新しました"
      redirect_to admin_member_path(@member)
    else
      render :edit
      flash[:alert] = "ユーザ情報の更新に失敗しました"
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
end
