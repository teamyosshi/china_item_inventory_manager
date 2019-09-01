require "application_system_test_case"

class ReserchesTest < ApplicationSystemTestCase
  setup do
    @reserch = reserches(:one)
  end

  test "visiting the index" do
    visit reserches_url
    assert_selector "h1", text: "Reserches"
  end

  test "creating a Reserch" do
    visit reserches_url
    click_on "New Reserch"

    fill_in "China image url", with: @reserch.china_image_url
    fill_in "China price", with: @reserch.china_price
    fill_in "China title", with: @reserch.china_title
    fill_in "China url", with: @reserch.china_url
    fill_in "Item", with: @reserch.item_id
    fill_in "Japan description", with: @reserch.japan_description
    fill_in "Japan image url", with: @reserch.japan_image_url
    fill_in "Japan price", with: @reserch.japan_price
    fill_in "Japan title", with: @reserch.japan_title
    fill_in "Japan url", with: @reserch.japan_url
    fill_in "User", with: @reserch.user_id
    click_on "Create Reserch"

    assert_text "Reserch was successfully created"
    click_on "Back"
  end

  test "updating a Reserch" do
    visit reserches_url
    click_on "Edit", match: :first

    fill_in "China image url", with: @reserch.china_image_url
    fill_in "China price", with: @reserch.china_price
    fill_in "China title", with: @reserch.china_title
    fill_in "China url", with: @reserch.china_url
    fill_in "Item", with: @reserch.item_id
    fill_in "Japan description", with: @reserch.japan_description
    fill_in "Japan image url", with: @reserch.japan_image_url
    fill_in "Japan price", with: @reserch.japan_price
    fill_in "Japan title", with: @reserch.japan_title
    fill_in "Japan url", with: @reserch.japan_url
    fill_in "User", with: @reserch.user_id
    click_on "Update Reserch"

    assert_text "Reserch was successfully updated"
    click_on "Back"
  end

  test "destroying a Reserch" do
    visit reserches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reserch was successfully destroyed"
  end
end
