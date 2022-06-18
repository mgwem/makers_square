class Public::MaterialsController < ApplicationController

  def index
    @material = Material.new
    @materials = current_member.materials
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private

  def material_params
    params.require(:material).permit(:name, :store, :price, :is_stocked, :material_image)
  end

end
