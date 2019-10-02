class Item < ApplicationRecord
    has_many :stocks, dependent: :destroy
end
