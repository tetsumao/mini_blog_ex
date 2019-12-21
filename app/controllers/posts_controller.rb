class PostsController < ApplicationController
  # ログイン認証
  before_action :authenticate_user!

  # 全体タイムライン
  def index
    # ページングと降順指定
    @posts = Post.page(params[:page]).per(10).order(created_at: "DESC")
  end

  # フォローしたユーザーのみのタイムライン
  def followings
    # ページングと降順指定
    @posts = current_user.followings_posts.page(params[:page]).per(10).order(created_at: "DESC")
  end

  # 投稿
  def create
    # 投稿生成
    @post = Post.new(post_params)
    # ユーザIDはログインユーザ
    @post.user_id = current_user.id

    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @post.save
        # 遷移元URLを取得
        path = URI.parse(request.referer).path
        recognized_path = Rails.application.routes.recognize_path(path)
        # 全体タイムラインなら遷移先指定
        if recognized_path[:controller] == 'posts' && recognized_path[:action] == 'index'
          @transition_url = path
        end
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
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:content)
  end
end
