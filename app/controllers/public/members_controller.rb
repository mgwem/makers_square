class Public::MembersController < ApplicationController
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

  def withdraw
  end

  def show
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :website_info, :profile_image)
  end

end