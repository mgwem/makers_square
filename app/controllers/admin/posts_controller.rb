class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).order(id: :DESC)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "作品を更新しました"
      redirect_to admin_post_path(@post)
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "作品を削除しました"
      redirect_to admin_posts_path
    else
      @genres = Genre.all
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :genre_id, :title, :explanation, :is_published,:is_hidden, :post_image)
  end

end
