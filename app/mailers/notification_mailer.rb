class NotificationMailer < ApplicationMailer
  # コメント通知
  def send_comment(comment)
    @comment = comment
    mail subject: "コメントが登録されました", to: @comment.post.user.email do |format|
      format.text
    end
  end
end
