class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).order(id: :DESC)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def member_posts
  end
end
