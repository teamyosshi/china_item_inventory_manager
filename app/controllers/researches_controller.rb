class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :edit, :update, :destroy]

  require 'open-uri'
  require 'nokogiri'

  # GET /researches
  # GET /researches.json
  def index
    @researches = Research.all
  end

  # GET /researches/1
  # GET /researches/1.json
  def show
  end

  # GET /researches/new
  def new
    @research = Research.new
  end

  # GET /researches/1/edit
  def edit
  end

  # POST /researches
  # POST /researches.json
  def create
    @research = Research.new(research_params)

    respond_to do |format|
      if @research.save
        format.html { redirect_to @research, notice: 'Research was successfully created.' }
        format.json { render :show, status: :created, location: @research }
      else
        format.html { render :new }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /researches/1
  # PATCH/PUT /researches/1.json
  def update
    respond_to do |format|
      if @research.update(research_params)
        format.html { redirect_to @research, notice: 'Research was successfully updated.' }
        format.json { render :show, status: :ok, location: @research }
      else
        format.html { render :edit }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    @research.destroy
    respond_to do |format|
      format.html { redirect_to researches_url, notice: 'Research was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # リサーチページ表示
  def item_research
    @researches = Research.paginate(page: params[:page], per_page: 50).order(created_at: "ASC")
    @research = Research.all
  end

  # スクレイピング
  def item_research_scrape

    @uri = "https://auctions.yahoo.co.jp/search/search?p=#{params[:search]}"
    @doc = Nokogiri::HTML(open(@uri),nil,"utf-8")
    charset = nil
    html = open(@uri) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # htmlをパース(解析)してオブジェクトを作成
    @doc = Nokogiri::HTML.parse(html, nil, charset)
    # 商品の各ページタイトル
    # @doc.xpath("//div[@class='Products Products--grid']/ul[@class='Products__items']/li[@class='Product'][1]/div[@class='Product__detail']/h3[@class='Product__title']/a[@class='Product__titleLink']").each do |node|
    #   node.text
      # Research.create(japan_title: node, user_id: current_user)
    end
    # 画像
    # debugger
    @doc.each do |photo|
      if photo.include?("#{params[:search]}")
        Research.create(japan_img: photo, user_id: current_user, item_id: 1)
      end
    end

    redirect_to item_research_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research
      @research = Research.find(params[:id])
    end

    def research_params
      params.require(:research).permit(:japan_image_url, :japan_title, :japan_url, :japan_description, :japan_price, :china_image_url, :china_title, :china_url, :china_price, :item_id, :user_id)
    end
end
