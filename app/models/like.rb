class Like < ApplicationRecord
  # ユーザ
  belongs_to :user
  # 投稿
  belongs_to :post

  # ユーザIDと投稿IDは必須
  validates :user_id, presence: true
  validates :post_id, presence: true
end
