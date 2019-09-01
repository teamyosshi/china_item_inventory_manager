require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    check "Amazon" if @item.amazon
    fill_in "China item image", with: @item.china_item_image
    fill_in "Item image", with: @item.item_image
    fill_in "Item number", with: @item.item_number
    fill_in "Jan code", with: @item.jan_code
    check "Mercari" if @item.mercari
    fill_in "Part number", with: @item.part_number
    check "Rakuma" if @item.rakuma
    check "Rakuten" if @item.rakuten
    fill_in "Simulate price", with: @item.simulate_price
    check "Yahoo" if @item.yahoo
    check "Yahooshoping" if @item.yahooshoping
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_url
    click_on "Edit", match: :first

    check "Amazon" if @item.amazon
    fill_in "China item image", with: @item.china_item_image
    fill_in "Item image", with: @item.item_image
    fill_in "Item number", with: @item.item_number
    fill_in "Jan code", with: @item.jan_code
    check "Mercari" if @item.mercari
    fill_in "Part number", with: @item.part_number
    check "Rakuma" if @item.rakuma
    check "Rakuten" if @item.rakuten
    fill_in "Simulate price", with: @item.simulate_price
    check "Yahoo" if @item.yahoo
    check "Yahooshoping" if @item.yahooshoping
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
