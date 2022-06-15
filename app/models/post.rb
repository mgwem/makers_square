class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :member
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :post_image

  validates :genre_id, presence: true
  validates :title, presence: true
  validates :is_published, presence: true

  # 作品写真のサイズ変更、デフォルト画像指定
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      post_image.attach(io: File.open(file_path), filename: 'default-post-image.png', content_type: 'image/png')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいね機能（存在するかどうか判定）
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  # キーワード検索（作品タイトル）
  def self.search_for_title(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end

  # キーワード検索（作品説明）
  def self.search_for_explanation(content, method)
    if method == 'perfect'
      Post.where(explanation: content)
    elsif method == 'forward'
      Post.where('explanation LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('explanation LIKE ?', '%'+content)
    else
      Post.where('explanation LIKE ?', '%'+content+'%')
    end
  end

end
