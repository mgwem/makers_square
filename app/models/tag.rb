class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tag_maps

  # キーワード検索（タグ）
  def self.search_for(content, method)
    if method == 'perfect'
      tags = Tag.where(tag_name: content)
    elsif method == 'forward'
      tags = Tag.where('tag_name LIKE ?', content+'%')
    elsif method == 'backward'
      tags = Tag.where('tag_name LIKE ?', '%'+content)
    else
      tags = Tag.where('tag_name LIKE ?', '%'+content+'%')
    end

    tag_posts = tags.inject(init = []) {|result, tag| result + tag.posts}
    Post.where(id: tag_posts.map(&:id))
  end

end
