class Public::PostMaterialsController < ApplicationController

  def new
    @post_material = Material.new
  end

  def create
    @post_material = Material.new(post_material_params)
    @post = Post.find(params[:id])
    @post_material.post_id = @post.id
  end

  def index
  end

  def update
  end

  def destroy
  end

  private

  def post_material_params
    params.require(:post_material).permit(:post_id, :material_id)
  end

end
