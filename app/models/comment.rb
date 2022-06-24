class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :member

  validates :comment, presence: true, length: {maximum:150}

  # 公開ステータス「公開」のコメントを取得
  scope :published, -> { where(is_hidden: false) }
  # created_atカラムを降順に並び替え
  scope :sorted, -> { order(created_at: :DESC) }
  # 公開コメントを新着順に並び替え
  scope :recent_comment, -> { published.sorted }

end
