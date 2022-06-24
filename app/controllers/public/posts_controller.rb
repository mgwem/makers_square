class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index, :tag_search, :genre_search]
  before_action :ensure_correct_member, only:[:edit, :update, :destroy]

  def new
    @post = Post.new(session[:post] || {})
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      session[:post] = nil
      flash[:notice] = "作品が投稿されました"
      redirect_to member_post_path(@post.member, @post)
    else
      session[:post] = @post.attributes.slice(*post_params.keys)
      flash[:danger] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @member = Member.find(params[:member_id])
    @posts = @member.posts.recent.limit(6)
    @comment = Comment.new
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
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "作品を更新しました"
      redirect_to member_post_path(@post.member, @post)
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "作品を削除しました"
      redirect_to posts_post_management_path
    else
      @genres = Genre.all
      @tag_list = @post.tags.pluck(:tag_name).join(",")
      render :edit
    end
  end

  def index
    @posts = Post.recent.page(params[:page])
  end

  def post_management
    @member = current_member
    @posts = @member.posts.sorted.page(params[:page])
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.recent.page(params[:page])
  end

  def genre_search
    @genre = Genre.find(params[:genre_id])
    @posts = @genre.posts.recent.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :genre_id, :title, :explanation, :is_published, :post_image)
  end

  def ensure_correct_member
    post = Post.find(params[:id])
    @member = post.member_id
    unless @member == current_member.id
      redirect_to root_path
    end
  end

end
