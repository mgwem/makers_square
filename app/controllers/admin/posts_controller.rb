class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).order(id: :DESC)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @materials = @post.materials
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
    @tag_list = @post.tags.pluck(:tag_name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "作品を更新しました"
      redirect_to admin_post_path(@post)
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to edit_admin_post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :genre_id, :title, :explanation, :is_published,:is_hidden, :post_image)
  end

end
