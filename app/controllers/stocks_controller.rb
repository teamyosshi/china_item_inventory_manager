class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end
  def inventory_control
    @stocks = Stock.all
    @items=Item.all
    @items_find=Item.includes(:stocks).all
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

  def product_inventory
    @this_year = Date.today.year.to_i
    @prev_year = Date.today.prev_year.year.to_i
    #今年のitemのstock取得
    @item_stocks = Stock.includes(:item).where("inventory_arrival_date LIKE ?", "%#{@this_year}%").order("inventory_arrival_date ASC")
    @item_stocks.each do |item_stock|
      #今年度仕入原価合計を計算
      cost_of_salse = item_stock.purchase_price.to_i * item_stock.original_stock.to_i
      @total_purchase_cost_this_year = @total_purchase_cost_this_year.to_i + cost_of_salse
      #今年度期末商品棚卸高の計算
      cost_salse = item_stock.purchase_price * item_stock.stock
      @period_end_product_inventory = @period_end_product_inventory.to_i + cost_salse
    end
    takeinventory_update
    #上からそのまま流すと@this_year_beginning_product_inventoryの中身がnilで始まった時にnewで流れていってしまうのでnilになることがある。
    if @this_year_beginning_product_inventory.nil?
    #@this_year_beginning_product_inventoryを再取得 もし上でnewになった時でも、これでnilではなくなる。
      @this_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @this_year)
      if @this_year_beginning_product_inventory.present?
        if @this_year_beginning_product_inventory.beginning_product_inventory.present? && @total_purchase_cost_this_year.present? && @period_end_product_inventory.present?
          @total_cost_of_sales = @this_year_beginning_product_inventory.beginning_product_inventory + @total_purchase_cost_this_year - @period_end_product_inventory
        end
        @this_year_beginning_product_inventory.update_attributes(cost_of_sales: @total_cost_of_sales, period_end_product_inventory: @period_end_product_inventory)
      end
    elsif @this_year_beginning_product_inventory.present?
      if @this_year_beginning_product_inventory.beginning_product_inventory.present? && @total_purchase_cost_this_year.present? && @period_end_product_inventory.present?
        @total_cost_of_sales = @this_year_beginning_product_inventory.beginning_product_inventory + @total_purchase_cost_this_year - @period_end_product_inventory
      end
      @this_year_beginning_product_inventory.update_attributes(cost_of_sales: @total_cost_of_sales, period_end_product_inventory: @period_end_product_inventory)
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
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:inventory_arrival_date, :purchase_price, :trager_name, :stock, :alert_border_line, :item_number_id)
    end

    def takeinventory_update
      @this_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @this_year)
      @prev_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @prev_year)
      #もし去年のTakeInventoryがなければ今年のTakeInventoryを作成(fiscal_yearに今年を入れておく)
      if @prev_year_beginning_product_inventory.nil? && @this_year_beginning_product_inventory.nil?
        record = TakeInventory.new(fiscal_year: @this_year)
        record.save
      #もし去年のデータがあって今年のデータが無かったら今年のデータを作成し作成日に今年を代入、去年のデータの期末商品棚卸高を今年の機種商品棚卸高に代入
      elsif @prev_year_beginning_product_inventory.present? && @this_year_beginning_product_inventory.nil?
        record = TakeInventory.new(fiscal_year: @this_year, beginning_product_inventory: @prev_year_beginning_product_inventory.period_end_product_inventory)
        record.save
      end
    end
end
