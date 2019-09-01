require "application_system_test_case"

class StocksTest < ApplicationSystemTestCase
  setup do
    @stock = stocks(:one)
  end

  test "visiting the index" do
    visit stocks_url
    assert_selector "h1", text: "Stocks"
  end

  test "creating a Stock" do
    visit stocks_url
    click_on "New Stock"

    fill_in "Alert border line", with: @stock.alert_border_line
    fill_in "Inventory arrival date", with: @stock.inventory_arrival_date
    fill_in "Item number", with: @stock.item_number_id
    fill_in "Purchase price", with: @stock.purchase_price
    fill_in "Stock", with: @stock.stock
    fill_in "Trager name", with: @stock.trager_name
    click_on "Create Stock"

    assert_text "Stock was successfully created"
    click_on "Back"
  end

  test "updating a Stock" do
    visit stocks_url
    click_on "Edit", match: :first

    fill_in "Alert border line", with: @stock.alert_border_line
    fill_in "Inventory arrival date", with: @stock.inventory_arrival_date
    fill_in "Item number", with: @stock.item_number_id
    fill_in "Purchase price", with: @stock.purchase_price
    fill_in "Stock", with: @stock.stock
    fill_in "Trager name", with: @stock.trager_name
    click_on "Update Stock"

    assert_text "Stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock" do
    visit stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock was successfully destroyed"
  end
end
