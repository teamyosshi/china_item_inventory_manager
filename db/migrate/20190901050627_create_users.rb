class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :employee_number
      t.string :line_id
      t.string :email, null: false
      t.string :address, null: false
      t.integer :phone_number
      t.string :account_bank_name, null: false
      t.integer :account_number, null: false
      t.integer :business_consignment_expenses, null: false
      t.string :password_digest, null: false
      t.boolean :inventory_manager_flg, null: false
      t.boolean :reserch_user_flg, null: false
      t.string :fired_flg, null: false
      t.integer :admin, null: false

      t.timestamps
    end
  end
end
