class TakeInventoryController < ApplicationController
  def update
    now_year = Date.today.to_s[0..3]
    @takeinventory = TakeInventory.find_by(fiscal_year: now_year)
    if @takeinventory.update(takeinventory_params)
      flash[:success] = "機種商品棚卸高を登録しました。"
    else
      flash[:danger] = "機種商品棚卸高に失敗しました。再度やり直してください。"
    end
    redirect_to stock_path(current_user)
  end
private
  def takeinventory_params
    params.permit(:beginning_product_inventory)
  end
end
