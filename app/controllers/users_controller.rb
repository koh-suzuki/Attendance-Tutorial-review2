class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :show, :destroy]
before_action :loggrd_in_user, only: [:index, :edit, :update, :show, :destroy]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のユーザー情報を削除しました。"
    redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    # beforeフィルター

    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。__
    def loggrd_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin
    end
end
