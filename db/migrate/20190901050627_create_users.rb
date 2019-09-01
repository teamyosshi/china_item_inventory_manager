class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :employee_number
      t.string :line_id
      t.string :email
      t.string :address
      t.integer :phone_number
      t.string :account_bank_name
      t.integer :account_number
      t.integer :business_consignment_expenses
      t.string :password_digest
      t.integer :inventory_manager_flg
      t.integer :reserch_user_flg
      t.string :fired_flg
      t.integer :admin

      t.timestamps
    end
  end
end
