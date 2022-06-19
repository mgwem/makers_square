class PostMaterial < ApplicationRecord

  belongs_to :post
  belongs_to :material

  validates :post_id, presence: true
  validates :material_id, presence: true

end
