class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update,:show]
  before_action :admin_user,　only: [:index, :destroy]
  skip_before_action  :admin_user,　only: :edit

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 50)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "アカウントを作成しました。"
      if @user.reserch_user_flg?
        redirect_to  item_research_path(current_user)
      elsif @user.inventory_manager_flg?
        redirect_to inventory_control_path(current_user)
      end
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:danger] = "ユーザーを削除しました。"
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :employee_number, :line_id, :email, :address, :phone_number, :password, :password_confirmation, :inventory_manager_flg, :reserch_user_flg, :account_bank_name, :account_number, :business_consignment_expenses)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to root_url
      end
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      if logged_in?
        unless current_user.admin?
          flash[:danger] =  "権限がありません。"
          if current_user.inventory_manager_flg?
            redirect_to inventory_control_path(current_user)
          elsif current_user.reserch_user_flg
            redirect_to item_research_path(current_user)
          else
            redirect_to root_url
          end
        end
      end
    end
end
