require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { item: { amazon: @item.amazon, china_item_image: @item.china_item_image, item_image: @item.item_image, item_number: @item.item_number, jan_code: @item.jan_code, mercari: @item.mercari, part_number: @item.part_number, rakuma: @item.rakuma, rakuten: @item.rakuten, simulate_price: @item.simulate_price, yahoo: @item.yahoo, yahooshoping: @item.yahooshoping } }
    end

    assert_redirected_to item_url(Item.last)
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { amazon: @item.amazon, china_item_image: @item.china_item_image, item_image: @item.item_image, item_number: @item.item_number, jan_code: @item.jan_code, mercari: @item.mercari, part_number: @item.part_number, rakuma: @item.rakuma, rakuten: @item.rakuten, simulate_price: @item.simulate_price, yahoo: @item.yahoo, yahooshoping: @item.yahooshoping } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to items_url
  end
end
