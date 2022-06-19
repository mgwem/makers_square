class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :following
  has_many :materials, dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :is_void, inclusion:{in: [true, false]}
  validates :is_deleted, inclusion:{in: [true, false]}

  # 管理ステータス「有効」の会員を取得
  scope :valid, -> { where(is_void: false) }
  # 会員ステータス「利用中」の会員を取得
  scope :active, -> { where(is_deleted: false) }
  # created_atカラムを降順に並び替え
  scope :sorted, -> { order(created_at: :DESC) }
  # 公開作品を新着順に並び替え
  scope :recent_member, -> { valid.active.sorted }

  # ゲストログイン
  def self.guest
    find_or_create_by!(name:'guest',email:'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = 'guest'
    end
  end

  # ユーザ画像のサイズ変更、デフォルト画像指定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-user-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-user-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # キーワード検索(ユーザー名)
  def self.search_for(content, method)
    if method == 'perfect'
      Member.where(name: content)
    elsif method == 'forward'
      Member.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Member.where('name LIKE ?', '%'+content)
    else
      Member.where('name LIKE ?', '%'+content+'%')
    end
  end

  # フォローする
  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  # フォロー外す
  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  # フォローしているかどうかの判定
  def following?(member)
    followings.include?(member)
  end

end
