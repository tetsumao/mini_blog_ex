# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  # コメント通知(http://localhost:3000/rails/mailers/notification_mailer/send_comment)
  def send_comment
    # 最後のコメントで確認
    comment = Comment.last
    NotificationMailer.send_comment(comment)
  end

  # ランキング(http://localhost:3000/rails/mailers/notification_mailer/send_ranking)
  def send_ranking
    # テストしやすくするため今日のランキングにする
    date = Date.today
    h_ranking = Post.ranking_hash(date)
    user = User.first
    NotificationMailer.send_ranking(date, h_ranking, user)
  end
end
