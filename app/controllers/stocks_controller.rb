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
    @stockslist=Stock.includes(:item).all
    @search=params[:search]
    if params[:kubun]=="1"
      @items_find=Item.includes(:stocks).search(params[:search])
    end
  end
  
  def csv_export
    find=params[:items_find]
    if find.present?
      @items_find2=Item.search(find)
    else
      @items_find2=Item.all
    end
  end
  def buyitem
    @buyitems=Buyitem.all
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

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    if @stock.update(stock_params)
       flash[:success] = "在庫データを変更しました"
       redirect_to "/users/#{current_user.id}/inventory_control"
    else
        flash[:warning] = "更新に失敗しました"
        render 'edit'
    end
  end
  def stock_new
  item_id=params[:id]
  @item=Item.find(item_id)
  @stock = Stock.new
  end 
  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def manynewbuyitem
    i=0
    stocktobuyitems_params.each{|id, val|item_id,check = val.values_at("item_id","check")
    if check=="1"
      item = Item.find(item_id)
      stock=Stock.find(id)
      @buyitem = Buyitem.new(
        japan_image_url:item.item_picture,
        japan_title:item.item_title,
        japan_url:stock.buy_item_url,
        japan_price:item.simulate_price,
        china_image_url:stock.buy_item_image_url,
        china_title:stock.buy_item_title,
        china_url:stock.buy_item_url,
        china_price:stock.purchase_price,
        user_id:current_user.id)
      if @buyitem.save
        i=i+1
      end
    end
    }
    if i>0
      flash[:success] = "#{i}件の在庫データを追加しました"
    else
      flash[:warning] = "商品は追加されませんでした"
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
      params.require(:stock).permit(:inventory_arrival_date, :purchase_price, :trader_name, :stock, :alert_border_line, :item_number_id)
    end
    
    def stocktobuyitems_params
      params.permit(stocktobuyitems: [:item_id,:check])[:stocktobuyitems]
    end
    def unlesslogin
      if current_user.nil?
        redirect_to "/"
      end
    end
end