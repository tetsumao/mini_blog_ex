class UsersController < ApplicationController
  # プロフィール画面
  def show
    @user = User.find(params[:id])
  end
end
