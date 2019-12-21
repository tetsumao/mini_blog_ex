class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:user_name]
  
  # user_name
  validates_uniqueness_of :user_name
  validates_presence_of :user_name

  # 投稿との連携
  has_many :posts, dependent: :destroy

  # ユーザ関連テーブルとの連携
  has_many :user_relations
  has_many :followings, through: :user_relations, source: :follow
  # いいねテーブルとの連携
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  # アルファベットのみ20字以内
  validates :user_name, format: /\A[a-zA-Z]+\z/, length: {maximum: 20}
  # プロフィールは200文字で制限
  validates :profile, length: {maximum: 200}
  # ブログURL
  validates :blog_url, format: /\A(|#{URI::regexp(%w(http https))})\z/

  # フォローの関係を追加・または取得する
  def follow(user)
    unless self.id == user.id
      self.user_relations.find_or_create_by(follow_id: user.id)
    end
  end

  # フォローを解除する
  def unfollow(user)
    user_relation = self.user_relations.find_by(follow_id: user.id)
    user_relation.destroy if user_relation.present?
  end

  # フォローしている？
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # フォローしているユーザの投稿一覧
  def followings_posts
    Post.where("user_id IN (?)", following_ids)
  end

  # いいねを追加・または取得する
  def like_post(post)
    self.likes.find_or_create_by(post_id: post.id)
  end

  # いいねを解除する
  def unlike_post(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like.present?
  end

  # いいねしている？
  def liking_post?(post)
    self.liked_posts.include?(post)
  end
end
