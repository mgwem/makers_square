class Public::MaterialsController < ApplicationController

  def index
    @materials = current_member.materials
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.member_id = current_member.id
    if @material.save
      flash[:notice] = "材料が登録されました"
      redirect_to materials_path
    else
      render :new
    end
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
