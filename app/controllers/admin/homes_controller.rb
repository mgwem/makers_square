class Admin::HomesController < ApplicationController
  def top
    @members = Member.page(params[:page])
  end
end
