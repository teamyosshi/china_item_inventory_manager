require 'test_helper'

class ReserchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reserch = reserches(:one)
  end

  test "should get index" do
    get reserches_url
    assert_response :success
  end

  test "should get new" do
    get new_reserch_url
    assert_response :success
  end

  test "should create reserch" do
    assert_difference('Reserch.count') do
      post reserches_url, params: { reserch: { china_image_url: @reserch.china_image_url, china_price: @reserch.china_price, china_title: @reserch.china_title, china_url: @reserch.china_url, item_id: @reserch.item_id, japan_description: @reserch.japan_description, japan_image_url: @reserch.japan_image_url, japan_price: @reserch.japan_price, japan_title: @reserch.japan_title, japan_url: @reserch.japan_url, user_id: @reserch.user_id } }
    end

    assert_redirected_to reserch_url(Reserch.last)
  end

  test "should show reserch" do
    get reserch_url(@reserch)
    assert_response :success
  end

  test "should get edit" do
    get edit_reserch_url(@reserch)
    assert_response :success
  end

  test "should update reserch" do
    patch reserch_url(@reserch), params: { reserch: { china_image_url: @reserch.china_image_url, china_price: @reserch.china_price, china_title: @reserch.china_title, china_url: @reserch.china_url, item_id: @reserch.item_id, japan_description: @reserch.japan_description, japan_image_url: @reserch.japan_image_url, japan_price: @reserch.japan_price, japan_title: @reserch.japan_title, japan_url: @reserch.japan_url, user_id: @reserch.user_id } }
    assert_redirected_to reserch_url(@reserch)
  end

  test "should destroy reserch" do
    assert_difference('Reserch.count', -1) do
      delete reserch_url(@reserch)
    end

    assert_redirected_to reserches_url
  end
end
