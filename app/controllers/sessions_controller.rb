class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。'
      if user.inventory_manager_flg == true || user.admin == true
        redirect_to inventory_control_path(user.id)
      else user.reserch_user_flg == true
        redirect_to item_research_path(user.id)
      end
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render 'static_pages/top'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end
end