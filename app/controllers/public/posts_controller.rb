class Public::PostsController < ApplicationController
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
    @posts = @member.posts.limit(6).order(id: :DESC)
    @comment = Comment.new
    @post_tags = @post.tags
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
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "作品を削除しました"
      redirect_to member_path(@post.member)
    else
      @genres = Genre.all
      render :edit
    end
  end

  def index
    @posts = Post.page(params[:page]).order(id: :DESC)
  end

  def post_management
    @member = current_member
    @posts = @member.posts.order(id: :DESC)
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).order(id: :DESC)
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :genre_id, :title, :explanation, :is_published, :post_image)
  end

end
