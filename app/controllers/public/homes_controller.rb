class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @posts = Post.recent.limit(6)
  end

  def about
  end
end
