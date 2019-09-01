json.extract! user, :id, :name, :employee_number, :line_id, :email, :address, :phone_number, :account_bank_name, :account_number, :business_consignment_expenses, :password_digest, :inventory_manager_flg, :reserch_user_flg, :fired_flg, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
