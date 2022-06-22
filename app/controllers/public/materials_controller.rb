class Public::MaterialsController < ApplicationController

  def index
    @materials = current_member.materials.page(params[:page]).order(created_at: :DESC)
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
      flash[:danger] = @material.errors.full_messages
      redirect_to new_material_path
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      flash[:notice] = "材料の情報を更新しました"
      redirect_to materials_path
    else
      flash[:danger] = @material.errors.full_messages
      redirect_to edit_material_path
    end
  end

  def destroy
    @material = Material.find(params[:id])
    if @material.destroy
      flash[:notice] = "材料を削除しました"
      redirect_to materials_path
    else
      flash[:alert] = "材料を削除できませんでした"
      redirect_to materials_path
    end
  end

  private

  def material_params
    params.require(:material).permit(:name, :store, :price, :is_stocked, :material_image)
  end

end
