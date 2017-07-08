class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #登録成功時のアクション
      flash[:success] = "ユーザー登録が完了しました！"
      redirect_to @user
    else
      #登録失敗時のアクション
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    #ストロングパラメーター
    def user_params
      params.require(:user).permit(:user_name, :email, :password,
                                   :password_confirmation)
    end
end
