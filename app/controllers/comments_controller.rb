class CommentsController < ApplicationController
  before_action :authenticate_user!

  # コメント
  def create
    @comment = current_user.comments.new(comment_params)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @comment.save
        NotificationMailer.send_comment(@comment).deliver_later
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  # コメント表示切替
  def switch
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
