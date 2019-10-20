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
    #今年取得
    @now_year = Date.today.to_s[0..3]
    #1年前取得
    @prev_year = Date.today.prev_year.to_s[0..3]
    #今年のitemのstock取得
    @items_stock = Stock.includes(:item).where("inventory_arrival_date LIKE ?", "%#{@now_year}%").order("inventory_arrival_date ASC")
    #今年のstockをeachで回して商品の今年の購入数と原価をかけて合計に代入
    @items_stock.each do |stock|
      #個々の在庫の合計原価を代入(購入した合計*原価)
      @cost_of_salse = stock.purchase_price * stock.original_stock
      #今年度仕入原価合計を用意
      @total_purchase_cost_this_year = @total_purchase_cost_this_year.to_i + @cost_of_salse
      #今年度期末商品棚卸高を計算するために残り在庫合計と原価を合わせたものを用意(残っている在庫*原価)
      @cost_salse = stock.purchase_price * stock.stock
      #今年度期末商品棚卸高の計算
      @period_end_product_inventory = @period_end_product_inventory.to_i + @cost_salse
    end
    #今年のTakeInventoryを取得
    @now_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @now_year)
    #1年前のTakeInventoryを取得
    @prev_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @prev_year)
    #もし去年のTakeInventoryがなければ今年のTakeInventoryを作成(fiscal_yearに今年を入れておく)
    if @prev_year_beginning_product_inventory.nil? && @now_year_beginning_product_inventory.nil?
      record = TakeInventory.new(fiscal_year: @now_year)
      record.save
    #もし去年のデータがあって今年のデータが無かったら今年のデータを作成し作成日に今年を代入、去年のデータの期末商品棚卸高を今年の機種商品棚卸高に代入
    elsif @prev_year_beginning_product_inventory.present? && @now_year_beginning_product_inventory.nil?
      record = TakeInventory.new(fiscal_year: @now_year, beginning_product_inventory: @prev_year_beginning_product_inventory.period_end_product_inventory)
      record.save
    end
    #上からそのまま流すと@now_year_beginning_product_inventoryの中身がnilで始まった時にnewで流れていってしまうのでnilになることがある。
    if @now_year_beginning_product_inventory.nil?
    #@now_year_beginning_product_inventoryを再取得 もし上でnewになった時でも、これでnilではなくなる。
      @now_year_beginning_product_inventory = TakeInventory.find_by(fiscal_year: @now_year)
      if @now_year_beginning_product_inventory.present?
        if @now_year_beginning_product_inventory.beginning_product_inventory.present?
          @total_cost_of_sales = @now_year_beginning_product_inventory.beginning_product_inventory + @total_purchase_cost_this_year - @period_end_product_inventory
        end
        #@now_year_beginning_product_inventoryのカラムを更新
        @now_year_beginning_product_inventory.update_attributes(cost_of_sales: @total_cost_of_sales, period_end_product_inventory: @period_end_product_inventory)
      end
    elsif @now_year_beginning_product_inventory.present?
      #@now_year_beginning_product_inventoryのカラムを更新
      if @now_year_beginning_product_inventory.beginning_product_inventory.present?
        @total_cost_of_sales = @now_year_beginning_product_inventory.beginning_product_inventory + @total_purchase_cost_this_year - @period_end_product_inventory
      end
      @now_year_beginning_product_inventory.update_attributes(cost_of_sales: @total_cost_of_sales, period_end_product_inventory: @period_end_product_inventory)
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
end
