class UserRelationsController < ApplicationController
  before_action :authenticate_user!

  # フォロー生成
  def create
    @user_follow = User.find(user_relation_params[:follow_id])
    @user_relation = current_user.follow(@user_follow)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @user_relation.save
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  # フォロー解除
  def destroy
    @user_follow = User.find(user_relation_params[:follow_id])
    @user_relation = current_user.unfollow(@user_follow)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @user_relation.destroy
        # フォローしたユーザのタイムラインなら遷移先指定
        @transition_url = referer_path_match_controller_action('posts', 'followings')
        format.js { render :destory_success }
      else
        format.js { render :destory_error }
      end
    end
  end

  private
    def user_relation_params
      params.require(:user_relation).permit(:follow_id)
    end
end
