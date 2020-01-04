class Item < ApplicationRecord
  has_many :stocks, dependent: :destroy
  accepts_nested_attributes_for :stocks
  validates :simulate_price, numericality: true, presence: true, on: :create
  validates :item_title, presence: true, on: :create
  validates :part_number, presence: true, on: [:create, :update]
  validates :buy_item_title, presence: true, on: :create
  validates :buy_item_url, presence: true, on: :create
  validates :item_japan_url, presence: true, on: :create

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Item.where('item_title LIKE ? OR part_number LIKE ?', "%#{search}%", "%#{search}%")
    end
  end

  def self.import(file)
    CSV.foreach(file.path,encoding: "Shift_JIS:UTF-8",headers: true) do |row|
      item=new
      # CSVからデータを取得し、設定する
      item.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      if item.save
        @proccesinng=1
      else
        @proccesinng=2
      end
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["item_picture", "part_number","item_title", "simulate_price","buy_item_title","buy_item_url","buy_item_url"]
  end
  #インポートできたどうかをコントローラーに渡すためのメソッド
  def self.get_processing
    @proccesinng
  end

end
