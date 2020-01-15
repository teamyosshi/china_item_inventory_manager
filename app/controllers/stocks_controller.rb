class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :unlesslogin, only: [:inventory_control,:show, :edit, :update, :destroy,:index]
  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end
  def inventory_control
    @stocks = Stock.all
      @items=Item.includes(:stocks).all
    @items_find=Item.all
    @search=params[:search]
    if params[:kubun]=="1"
      @items_find=Item.includes(:stocks).search(params[:search])
    end
  end
  
  def csv_export
      send_data render_to_string, filename: "#{Time.now.strftime("%Y_%m%d_%H%M%S")}_item_products.csv", type: :csv
  end

  def buyitem
    @buyitems=Buyitem.all
  end
  def buyitem_edit
    buyitem=Buyitem.find(params[:id])
    buyitem.japan_description=params[:japan_description]
    if buyitem.save
      flash[:success]="備考を更新しました"
    else
      flash[:danger]="備考に失敗しました"
    end
    redirect_to "/users/#{current_user.id}/buyitem"
  end
  def buyitem_delete
    buyitem=Buyitem.find(params[:id])
    begin
    buyitem.destroy
      flash[:success]="データを削除しました"
    rescue => e
      flash[:danger]="データ削除に失敗しました"
    end
    redirect_to "/users/#{current_user.id}/buyitem"
  end
  def product_inventory
    @this_year = Date.today.year.to_s
    @prev_year = Date.today.prev_year.year.to_s
    #今年のitemのstock取得
    @item_stocks = Stock.includes(:item).where("cast(inventory_arrival_date as text) LIKE ?", "%#{@this_year}%").order("inventory_arrival_date ASC")
    calculation_item_cost
    Stock.takeinventory_find
    Stock.takeinventory_create
    #上からそのまま流すと@this_year_beginning_product_inventoryの中身がnilで始まった時にnewで流れていってしまうのでnilになることがある。
    if @this_year_beginning_product_inventory.nil?
    #@this_year_beginning_product_inventoryを再取得 もし上でnewになった時でも、これでnilではなくなる。
      @this_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @this_year)
      if @this_year_beginning_product_inventory.present?
        calculation_of_total_amount
      end
    elsif @this_year_beginning_product_inventory.present?
      calculation_of_total_amount
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "#{@this_year}年の棚卸し情報.csv", type: :csv
      end
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end
  def new
    @stock = Stock.new
  end
  def edit
  end
  def update
    if @stock.update(stock_params)
       flash[:success] = "#{Item.find(@stock.item_id).item_title}の在庫データを変更しました"
       redirect_to "/users/#{current_user.id}/inventory_control"
    else
      flash[:danger] = "更新に失敗しました。必須項目の入力等ご確認下さい。"
      render 'edit'
    end
  end
  def stock_new
    @item=Item.find(params[:id])
    @stock=Stock.new
  end
  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      flash[:success] = "#{Item.find(@stock.item_id).item_title}在庫データを登録しました"
      redirect_to "/users/#{current_user.id}/inventory_control"
    else
      flash[:danger] = "登録に失敗しました"
      render 'stock_new'
    end
  end 
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def manynewbuyitem
    count=NUM
    stocktobuyitems_params.each{|id, val|item_id,check,japan_description = val.values_at(params["stocktobuyitems"][:id],"check","japan_description")
    if check=="1"
      item = Item.find(id)
      @buyitem = Buyitem.new(
        japan_image_url:item.item_picture,
        japan_title:item.item_title,
        japan_url:item.item_japan_url,
        japan_price:item.simulate_price,
        japan_description:japan_description,
        china_image_url:item.china_item_picture,
        china_title:item.buy_item_title,
        china_url:item.buy_item_url,
        # china_price:stock.purchase_price,
        user_id:current_user.id)
      if @buyitem.save
        count=count+1
      end
    end
    }
    if count>0
      flash[:success] = "#{count}件の在庫データを追加しました"
    else
      flash[:danger] = "商品は追加されませんでした"
    end
    redirect_to "/users/#{current_user.id}/buyitem"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:inventory_arrival_date,:purchase_price,:trader_name,:original_stock,:stock,:alert_border_line,:item_id,:buy_item_to_jpy,:buy_item_to_cny,:buy_item_image_url)
    end
    
    def stocktobuyitems_params
      params.permit(stocktobuyitems: [:check,:japan_description])[:stocktobuyitems]
    end

    def unlesslogin
      if current_user.nil?
        redirect_to "/"
      end
    end
end