class StaticPagesController < ApplicationController
  def top
    if logged_in?
      flash[:danger] = "すでにログインしています。"
      if current_user.admin? || current_user.inventory_manager_flg?
        redirect_to inventory_control_path(current_user)
      elsif current_user.reserch_user_flg?
        redirect_to item_research_path(current_user)
      end
    end
  end
end
