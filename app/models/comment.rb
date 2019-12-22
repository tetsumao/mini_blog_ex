class Comment < ApplicationRecord
  # 140文字で制限
  validates :content, length: {maximum: 140}

  # ユーザとの連携
  belongs_to :user
  # 投稿との連携
  belongs_to :post
end
