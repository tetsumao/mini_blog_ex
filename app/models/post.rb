class Post < ApplicationRecord
  # 140文字で制限
  validates :content, length: {maximum: 140}
  # 画像登録
  mount_uploader :picture, PictureUploader

  # ユーザと連携
  belongs_to :user
  # コメントとの連携
  has_many :comments

  # いいねテーブルとの連携
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  # 指定日のいいね数ランキングトップ10の投稿の {key: 投稿、val: [順位, カウンタ]} のハッシュを返す
  def self.ranking_hash(date)
    h_ranking = {}
    # いいね数ランキングトップ10の投稿ID:カウンタハッシュを取得
    h_like_count = Like.group(:post_id)
      .where('created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day)
      .order('COUNT(post_id) DESC').limit(10).count(:post_id)
    # 投稿があればメール通知
    if h_like_count.size > 0
      # 同一順位を考慮
      current_no = 0
      current_like_count = 0
      # 投稿を一括取得(ランキング順にソート)してループ
      ids = h_like_count.keys
      Post.where(id: ids).sort_by{|p| ids.index(p.id)}.each.with_index(1) do |post, no|
        # いいね数を取得
        like_count = h_like_count[post.id]
        # 前データと同じなら順位を更新しない
        current_no = no if (current_like_count > like_count || current_like_count == 0)
        current_like_count = like_count
        # key: 投稿、val: [順位, カウンタ]
        h_ranking[post] = [current_no, current_like_count]
      end
    end
    h_ranking
  end
end
