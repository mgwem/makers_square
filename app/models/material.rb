class Material < ApplicationRecord

  belongs_to :member

  has_one_attached :material_image

  # 材料写真のサイズ変更、デフォルト画像指定
  def get_material_image(width, height)
    unless material_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      material_image.attach(io: File.open(file_path), filename: 'default-post-image.png', content_type: 'image/png')
    end
    material_image.variant(resize_to_limit: [width, height]).processed
  end

end
