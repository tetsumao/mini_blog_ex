class CommentsController < ApplicationController
  # ログイン認証
  before_action :authenticate_user!

  # コメント
  def create
    # コメント生成
    @comment = Comment.new(comment_params)
    # ユーザIDはログインユーザ
    @comment.user_id = current_user.id

    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @comment.save
        # 後でメール送信
        NotificationMailer.send_comment(@comment).deliver_later
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  # コメント表示切替
  def switch
    # 投稿を取得
    @post = Post.find(params[:post_id])
    # コメント表示かどうかをbool変換
    @open = ActiveModel::Type::Boolean.new.cast(params[:open])

    # Ajax呼び出しのみ有効
    respond_to do |format|
      format.js { render :switch }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
