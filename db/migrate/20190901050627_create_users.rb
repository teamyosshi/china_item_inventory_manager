class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :employee_number
      t.string :line_id
      t.string :email, null: false
      t.string :address, null: false
      t.string :phone_number
      t.string :account_bank_name, null: false, default: "1"
      t.integer :account_number, null: false, default: "1"
      t.integer :business_consignment_expenses, null: false, default: "1"
      t.string :password_digest, null: false
      t.boolean :inventory_manager_flg, null: false, default: false
      t.boolean :reserch_user_flg, null: false, default: false
      t.string :fired_flg, null: false, default: ""
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
  end
end
