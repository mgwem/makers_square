class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index, :tag_search, :genre_search]
  before_action :ensure_correct_member, only:[:edit, :update, :destroy]
  before_action :ensure_correct_post_member, only:[:show]
  before_action :ensure_correct_post, only:[:show]

  def new
    @post = Post.new
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
      @genres = Genre.all
      render :new
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
      @genres = Genre.all
      @tag_list = @post.tags.pluck(:tag_name).join(",")
      render :edit
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
    @genres = Genre.all
  end

  # 作品管理
  def post_management
    @member = current_member
    @posts = @member.posts.sorted.page(params[:page])
  end

  # タグのリンク押下時
  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.recent.page(params[:page])
  end

  # ジャンル検索
  def genre_search
    @genre = Genre.find(params[:genre_id])
    @posts = @genre.posts.recent.page(params[:page])
    @genres = Genre.all
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

  # 作品詳細URLで作品の投稿者とmember_idが合わなければトップ画面に遷移
  def ensure_correct_post_member
    post = Post.find(params[:id])
    member = Member.find(params[:member_id])
    unless member.id == post.member_id
      redirect_to root_path
    end
  end

  # 非公開作品の閲覧権限確認（管理者と投稿者のみ閲覧可）
  def ensure_correct_post
    post = Post.find(params[:id])
    @member = post.member_id
    unless post.is_hidden == false && post.is_published == true
      unless member_signed_in?
        redirect_to root_path
      else
        unless @member == current_member.id
          redirect_to root_path
        end
      end
    end
  end

end
