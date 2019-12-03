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
    @researches = Research.paginate(page: params[:page], per_page: 50).order(japan_price: "ASC")
  end

# スクレイピング
def item_research_scrape
  require 'mechanize'
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
  #   # 商品タイトル取得
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
  # redirect_to item_research_url(japan_min_price: japan_min_price, japan_max_price: japan_max_price)

  puts "中国商品・・・・・・・・・・・・・・・・・・・・・"
  agent = Mechanize.new
  page = agent.get("https://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=watch")
  doc = page.search('//script')

  puts "画像URLをリサーチします・・・・・・・・・・・・・・・・・・・・・"
  # 空白にカンマを入れ、特定の取り出しやすい文字列に修正し、カンマ区切りで分割、一意性ありにしてダブりを消して配列にした。
  image_url_list = doc.text.gsub(" ",",").gsub('\\/\\/s.alicdn.com\\/@sc01\\/','"https://s.alicdn.com/@sc01/').gsub('"','').split(',').uniq.to_a

  # 配列を作るための準備
  @item_no ||= 0
  # 最後の一括バルクインサートに使用する、アイテムナンバーの配列を作る準備
  @item_number_list = [@item_no]
  hash = Hash.new { |h,k| h[k] = {} }

  image_url_list.each do |image_url_and_dust|     
    if image_url_and_dust.include?('mainImage:https://s.alicdn.com/@sc01/')
      @item_no += 1
      image_url_and_dust.slice!(0..9)
      #ごみがとれたことを明示
      image_url = image_url_and_dust
      if hash["#{@item_no - 1}"]["china_image_url"].present? && hash["#{@item_no - 1}"]["china_image_url"][-30..-1] == image_url[-30..-1]
        puts "#{@item_no}は前回と画像イメージが同じなのでスキップ"
        @item_no -= 1
        next
      end
    puts "#{@item_no}番のタイトルを正常に処理しました。"
    hash["#{@item_no}"]["china_image_url"] = image_url
    #無事ハッシュに追加できたら、最後の一括バルクインサートのための配列の準備をする。
    @item_number_list.push("#{@item_no}")
    end
  end

  puts "つづけてタイトルをリサーチします・・・・・・・・・・・・・・・・・・・・・"
  @item_no = 0
  titles_and_dusts = doc.text.gsub('"','').split(',').uniq.to_a
  titles_and_dusts.each do |title_and_dust|  
    if title_and_dust.include?('puretitle:')
      title_and_dust.slice!(0..9)
      @item_no += 1
      puts "#{@item_no}番のタイトルを正常に処理しました。"
      hash["#{@item_no}"]["china_title"] = title_and_dust
    end
  end

  puts "つづけてURLをリサーチします・・・・・・・・・・・・・・・・・・・・・"
  @item_no = 0
  item_urls_and_dusts = doc.text.gsub('"','').gsub('\\/\\/www.alibaba.com\\/product-detail\\/','https://www.alibaba.com/product-detail/').split(',').uniq.to_a

  item_urls_and_dusts.each do |item_url| 
    if item_url.include?('productUrl:')
      item_url.slice!(0..10)
      @item_no += 1
      puts "#{@item_no}番のURLを正常に処理しました。"
      hash["#{@item_no}"]["china_url"] = item_url
    end
  end

  puts "つづけて価格をリサーチします・・・・・・・・・・・・・・・・・・・・・"
  @item_no = 0
  prices_and_dusts = doc.text.gsub('"','').gsub('-',',-,').gsub('US ','').gsub('$','').split(',').uniq.to_a
  prices_and_dusts.each do |prices_and_dust|  
    if prices_and_dust.include?('price:')
      prices_and_dust.slice!(0..5)
      @item_no += 1
      puts "#{@item_no}番の価格を正常に処理しました。"
      hash["#{@item_no}"]["china_price"] = prices_and_dust.to_f
    end
  end
  # カラムごとの配列を作って、bulk insert
  user = User.find(params[:id])
  researches = []
  @item_number_list.each do |item_number|
    researches << user.researches.new(
                    :china_image_url => hash[item_number]["china_image_url"],
                    :china_title => hash[item_number]["china_title"],
                    :china_url => hash[item_number]["china_url"],
                    :china_price => hash[item_number]["china_price"]
                    )
    end
  user.researches.import researches
  flash[:success] = '商品のスクレイピングに成功しました。'
  redirect_to item_research_url
end

  def update_resarch
    @user = User.find(params[:id])
    if research_update_invaflid?
      research_update_params.each do |id, item|
        research = Research.find(id)
        research.update_attributes(item)
      end
      @japan_item = Research.find_by(jpn_reseach_check: 1)
      @china_item = Research.find_by(chn_reseach_check: 1)
      item = Item.new(item_title: @japan_item.japan_title,item_picture: @japan_item.japan_image_url, china_item_picture: @china_item.china_image_url)
      item.save(validate: false)
      flash[:success] = "リサーチアイテムに基づいた商品の作成に成功しました。"
      redirect_to item_research_path(current_user)
    else
      flash[:danger] = "リサーチアイテムに基づいた商品の作成に成功しました。再度やり直してください。"
      redirect_to item_research_path(current_user)
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_research
    @research = Research.find(params[:id])
  end

  def research_params
    params.require(:research).permit(:japan_image_url, :japan_title, :japan_url, :japan_description, :japan_price, :china_image_url, :china_title, :china_url, :china_price, :item_id, :user_id)
  end

  def research_update_params
    params.permit(researches: [:jpn_reseach_check , :chn_reseach_check])[:researches]
  end
end