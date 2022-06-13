class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
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
    @member_posts = @member.posts.limit(6).order(id: :DESC)
  end

  def edit
  end

  def upadate
  end

  def destroy
  end

  def index
    @posts = Post.page(params[:page]).order(id: :DESC)
  end

  def post_management
  end

  def member_posts
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :genre_id, :title, :explanation, :is_published, :post_image)
  end

end
