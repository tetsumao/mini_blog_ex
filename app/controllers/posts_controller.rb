class PostsController < ApplicationController
  before_action :authenticate_user!

  # 全体タイムライン
  def index
    @posts = Post.includes(:user).page(params[:page]).per(10).order(created_at: "DESC")
  end

  # フォローしたユーザーのみのタイムライン
  def followings
    @posts = current_user.followings_posts.includes(:user).page(params[:page]).per(10).order(created_at: "DESC")
  end

  # 投稿表示
  def show
    @post = Post.find(params[:id])
  end

  # 投稿
  def create
    @post = current_user.posts.build(post_params)
    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @post.save
        # 全体タイムラインなら遷移先指定
        @transition_url = referer_path_match_controller_action('posts', 'index')
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  # いいねしているユーザ一覧部分テンプレート
  def liked_users
    @post = Post.find(params[:id])
    # Ajax呼び出しのみ有効
    respond_to do |format|
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :picture)
    end
end
