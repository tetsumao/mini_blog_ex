class NotificationMailer < ApplicationMailer
  # コメント通知
  def send_comment(comment)
    @comment = comment
    mail subject: "コメントが登録されました", to: @comment.post.user.email do |format|
      format.text
    end
  end

  # ランキング
  def send_ranking(date, h_ranking, user)
    @date = date
    @h_ranking = h_ranking
    @user = user
    mail subject: @date.strftime("%Y/%m/%d") + " の「いいね」数ランキング", to: @user.email do |format|
      format.html
    end
  end
end
