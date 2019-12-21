class LikesController < ApplicationController
  # ログイン認証
  before_action :authenticate_user!

  # いいね生成
  def create
    @post = Post.find(like_params[:post_id])
    @like = current_user.like_post(@post)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @like.save
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  # いいね解除
  def destroy
    @post = Post.find(like_params[:post_id])
    @like = current_user.unlike_post(@post)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @like.destroy
        format.js { render :destory_success }
      else
        format.js { render :destory_error }
      end
    end
  end

  private
  def like_params
    params.require(:like).permit(:post_id)
  end
end
