class Public::PostMaterialsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member

  def new
    @post = Post.find(params[:post_id])
    @post_material = PostMaterial.new
    @materials = current_member.materials.order(created_at: :DESC)
  end

  def create
    @post_material = PostMaterial.new(post_material_params)
    material_ids = params[:post_material][:material_id]
    ActiveRecord::Base.transaction do
      material_ids.each do |material_id|
        post_material = PostMaterial.new
        post_material.material_id = material_id
        post_material.post_id = params[:post_id]
        post_material.save!
      end
      flash[:notice] = "登録が完了しました"
      post = Post.find(params[:post_id])
      redirect_to member_post_path(post.member, post)
    end
  rescue => e
    flash[:alert] = "登録に失敗しました"
    if e.message.include?('empty: post_material')
      flash[:alert] += '[材料を選択してください]'
    end
    @post = Post.find(params[:post_id])
    redirect_to new_post_post_material_path(@post)
  end

  # 作品に登録している材料表示（編集画面）
  def index
    @post = Post.find(params[:post_id])
    @post_material = PostMaterial.new
    @materials = current_member.materials.order(created_at: :DESC)
    @post_materials = @post.post_materials
  end

  def post_material_edit
    @post_material = PostMaterial.new(post_material_params)
    material_ids = params[:post_material][:material_id]
    post = Post.find(params[:post_id])
    post_materials = post.post_materials
    ActiveRecord::Base.transaction do
      # 作品に登録している材料があったら削除
      if post_materials.exists?
        post_materials.each do |post_material_old|
          post_material_old.destroy!
        end
      end
      # チェックの入った材料を登録
      material_ids.each do |material_id|
        post_material = PostMaterial.new
        post_material.material_id = material_id
        post_material.post_id = params[:post_id]
        post_material.save!
      end
      flash[:notice] = "登録が完了しました"
      redirect_to member_post_path(post.member, post)
    end
  rescue => e
    flash[:alert] = "登録に失敗しました"
    if e.message.include?('empty: post_material')
      flash[:alert] += '[材料を選択してください]'
    end
    @post = Post.find(params[:post_id])
    redirect_to post_post_materials_path(@post)
  end

  def destroy_all
    @post = Post.find(params[:post_id])
    post_materials = @post.post_materials
    ActiveRecord::Base.transaction do
      post_materials.each do |post_material|
        post_material.destroy!
      end
      flash[:notice] = "登録を取り消しました"
      redirect_to member_post_path(@post.member, @post)
    end
  rescue
    flash[:alert] = "登録取消に失敗しました"
    @post = Post.find(params[:post_id])
    redirect_to post_post_materials_path(@post)
  end

  private

  def post_material_params
    params.require(:post_material).permit(:post_id, material_id:[])
  end

  def ensure_correct_member
    post = Post.find(params[:post_id])
    @member = post.member_id
    unless @member == current_member.id
      redirect_to root_path
    end
  end

end
