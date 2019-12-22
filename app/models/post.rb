class Post < ApplicationRecord
  # 140文字で制限
  validates :content, length: {maximum: 140}

  # ユーザと連携
  belongs_to :user
  # コメントとの連携
  has_many :comments

  # いいねテーブルとの連携
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
end
