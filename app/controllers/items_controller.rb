class ItemsController < ApplicationController
  protect_from_forgery except: :destroy_many # destroy_manyアクションを除外
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  def import
    begin
      Item.import(params[:file])
      if Item.get_processing==1
        flash[:success] = "インポートに成功しました"
      else
        flash[:warning] = "インポートに失敗しました"
      end
    rescue => e
      logger.error e
      flash[:warning] = "ＣＳＶファイルを選択して下さい"
    end
    redirect_to "/users/#{current_user.id}/inventory_control"
  end
  def product_scarce
    @items=Item.includes(:stocks)
  end
  
  def product_item_number
    item=Item.find(params[:id])
    item.part_number=params[:part_number]
    item.save
    flash[:success] = "製品番号を変更しました"
    redirect_to "/users/#{current_user.id}/product_scarce"
  end
  #僅少商品のみ
  def csv_scarceexport
      @items=Item.all
  end
  
  #売切れ商品一覧
  def csv_soldoutexport
      @items=Item.all
  end
  
  def sold_out
    @items=Item.includes(:stocks)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @item.update(item_params)
       flash[:success] = "商品データを変更しました"
       redirect_to "/users/#{current_user.id}/sold_out"
    else
        flash[:warning] = "更新に失敗しました"
        render 'edit'
    end
  end
  
  def destroy_many
      if params[:deletes].present?
        delete_list = params[:deletes].keys
        ActiveRecord::Base.transaction do
          if Item.destroy(delete_list)
            flash[:success] ="削除に成功しました"
          end
        end
      else
        flash[:warning] = "失敗しました"
      end
      redirect_to request.referer
  end
  
  def destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_number, :item_image, :china_item_image, :part_number, :jan_code, :simulate_price, :yahoo, :amazon, :mercari, :rakuma, :rakuten, :yahooshoping)
    end
end
