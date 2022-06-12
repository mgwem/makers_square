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
      flash[:notice] = "ユーザ情報を更新しました"
      redirect_to admin_member_path(@member)
    else
      render :edit
      flash[:alert] = "ユーザ情報の更新に失敗しました"
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :website_info, :profile_image, :is_void)
  end
end
