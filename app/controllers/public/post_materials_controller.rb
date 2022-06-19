class Public::PostMaterialsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @post_material = PostMaterial.new
    @materials = current_member.materials
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
      flash[:notice] = "登録完了"
      redirect_to posts_post_management_path
    end
  rescue => e
    @materials = current_member.materials
    flash[:alert] = "登録失敗"
    render :new
  end

  def index
    @post = Post.find(params[:post_id])
  end

  def update
  end

  def destroy
  end

  private

  def post_material_params
    params.require(:post_material).permit(:post_id, material_id:[])
  end

end
