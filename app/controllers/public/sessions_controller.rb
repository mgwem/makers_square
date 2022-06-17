# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_member, only: [:create]
  
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to root_path, notice: 'gestでログイン'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_member
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
    if @member.valid_password?(params[:member][:password]) && (@member.is_void == true)
      flash[:alert] = "管理者によって利用を制限されています"
      redirect_to new_member_registration_path
    elsif @member.valid_password?(params[:member][:password]) && (@member.is_deleted == true)
      flash[:alert] = "退会済みです。新規登録をしてご利用ください。"
      redirect_to new_member_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
