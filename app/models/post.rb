class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :member
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :post_image

  validates :genre_id, presence: true
  validates :title, presence: true
  validates :is_published, inclusion:{in: [true, false]}
  validates :is_hidden, inclusion:{in: [true, false]}

  # 作品ステータス「有効」の作品を取得（管理者側公開設定）
  scope :activate, -> { where(is_hidden: false) }
  # 公開ステータス「公開」の作品を取得（会員側公開設定）
  scope :published, -> { where(is_published: true) }
  # created_atカラムを降順に並び替え
  scope :sorted, -> { order(created_at: :DESC) }
  # 公開作品を新着順に並び替え
  scope :recent, -> { activate.published.sorted }

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
  def self.search_title_for(content, method)
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
  def self.search_explanation_for(content, method)
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

  #タグテーブルへの保存
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # 入力されたタグからタグテーブルにあるタグを削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    # 入力されたタグからタグテーブルにないタグは追加
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

end
