class Item < ApplicationRecord
    has_many :stocks, dependent: :destroy
 
    def self.search(search) #self.でクラスメソッドとしている
        if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
            #Item.where(['item_number LIKE ?', "%#{search}%"])
            Item.where('item_number LIKE ? OR part_number LIKE ?', "%#{search}%", "%#{search}%")
        #else
            #Item.all #全て表示。
        end
    end
end
