require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Account bank name", with: @user.account_bank_name
    fill_in "Account number", with: @user.account_number
    fill_in "Address", with: @user.address
    fill_in "Admin", with: @user.admin
    fill_in "Business consignment expenses", with: @user.business_consignment_expenses
    fill_in "Email", with: @user.email
    fill_in "Employee number", with: @user.employee_number
    fill_in "Fired flg", with: @user.fired_flg
    fill_in "Inventory manager flg", with: @user.inventory_manager_flg
    fill_in "Line", with: @user.line_id
    fill_in "Name", with: @user.name
    fill_in "Password digest", with: @user.password_digest
    fill_in "Phone number", with: @user.phone_number
    fill_in "Reserch user flg", with: @user.reserch_user_flg
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Account bank name", with: @user.account_bank_name
    fill_in "Account number", with: @user.account_number
    fill_in "Address", with: @user.address
    fill_in "Admin", with: @user.admin
    fill_in "Business consignment expenses", with: @user.business_consignment_expenses
    fill_in "Email", with: @user.email
    fill_in "Employee number", with: @user.employee_number
    fill_in "Fired flg", with: @user.fired_flg
    fill_in "Inventory manager flg", with: @user.inventory_manager_flg
    fill_in "Line", with: @user.line_id
    fill_in "Name", with: @user.name
    fill_in "Password digest", with: @user.password_digest
    fill_in "Phone number", with: @user.phone_number
    fill_in "Reserch user flg", with: @user.reserch_user_flg
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
