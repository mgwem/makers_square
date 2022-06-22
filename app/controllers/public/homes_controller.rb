class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @posts = Post.recent.limit(6)
  end

  def about
  end

  def signup_error
    redirect_to new_member_registration_path
  end
end
