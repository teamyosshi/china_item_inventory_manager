require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { account_bank_name: @user.account_bank_name, account_number: @user.account_number, address: @user.address, admin: @user.admin, business_consignment_expenses: @user.business_consignment_expenses, email: @user.email, employee_number: @user.employee_number, fired_flg: @user.fired_flg, inventory_manager_flg: @user.inventory_manager_flg, line_id: @user.line_id, name: @user.name, password_digest: @user.password_digest, phone_number: @user.phone_number, reserch_user_flg: @user.reserch_user_flg } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { account_bank_name: @user.account_bank_name, account_number: @user.account_number, address: @user.address, admin: @user.admin, business_consignment_expenses: @user.business_consignment_expenses, email: @user.email, employee_number: @user.employee_number, fired_flg: @user.fired_flg, inventory_manager_flg: @user.inventory_manager_flg, line_id: @user.line_id, name: @user.name, password_digest: @user.password_digest, phone_number: @user.phone_number, reserch_user_flg: @user.reserch_user_flg } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
