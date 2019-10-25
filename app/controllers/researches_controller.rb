class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :edit, :update, :destroy]

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
    @user = User.find(params[:id])
    @researches = Research.paginate(page: params[:page], per_page: 50).order(japan_price: "ASC").where(japan_price: params[:japan_min_price]..params[:japan_max_price])
    @research = Research.all
  end

  # スクレイピング
  def item_research_scrape
    @user = User.find(params[:id])
    Research.delete_all
    agent = Mechanize.new
    page = agent.get("https://auctions.yahoo.co.jp/search/search?p=#{params[:search]}")
    # 配列を作る準備/未定義時0代入
    @research_no ||= 0
    # リサーチナンバーの配列を作る準備
    @research_number_list = []
    # 多次元（2次元）ハッシュの初期化　hash["a"]["b"] = 1 => {"a"=>{"b"=>1}}
    hash = Hash.new { |h,k| h[k] = {} }
    # リサーチ額を絶対パスで取る準備
    num = -1
    doc = page.search("//li[@class='Product']")
    doc.each do |node|
      @research_no += 1
      @research_number_list.push("#{@research_no}")
      # 商品画像取得
      @image = node.css('img')[0].attribute('src').inner_text
      hash["#{@research_no}"][:image] = @image
      # 商品タイトル取得
      @title = node.css('h3 a')[0].attribute('title').inner_text
      hash["#{@research_no}"][:title] = @title
      # リサーチURL習得
      @research_url = node.css('h3')[0].attribute('href').inner_text
      hash["#{@research_no}"][:research_url] = @research_url
      # リサーチ額取得
      @japan_min_price = params[:japan_min_price]
      @japan_max_price = params[:japan_max_price]
      num += 1
      @japan_price = node.search("//span[@class='Product__priceValue u-textRed']")[num].inner_text.gsub(/[^\d]/, "").to_i
      hash["#{@research_no}"][:japan_price] = @japan_price
    end
    @research_number_list.each do |research_number|
      Research.create(
          japan_title: hash[research_number][:title],
          japan_image_url: hash[research_number][:image],
          japan_url: hash[research_number][:research_url],
          japan_price: hash[research_number][:japan_price],
          user_id: 1)
    end
    japan_min_price = params[:japan_min_price]
    japan_max_price = params[:japan_max_price]
    redirect_to item_research_url(japan_min_price: japan_min_price, japan_max_price: japan_max_price)
  end

  def product_registration
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
