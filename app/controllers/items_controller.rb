class ItemsController < ApplicationController
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
      redirect_to "/users/#{current_user.id}/inventory_control"
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
