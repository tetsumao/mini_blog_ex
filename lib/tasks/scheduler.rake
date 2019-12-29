namespace :scheduler do
  desc 'Heroku schedulerから実行されるランキング集計タスク'
  task ranking: :environment do
    # 前日のランキング送信
    date = Date.yesterday
    # いいね数ランキングトップ10の投稿の {key: 投稿、val: [順位, カウンタ]} のハッシュ
    h_ranking = Post.ranking_hash(date)
    # メールアドレスのある全ユーザ
    users = User.where.not(email: [nil, ''])
    # ユーザ別々に送信
    users.each do |user|
      NotificationMailer.send_ranking(date, h_ranking, user).deliver
    end
  end
end
