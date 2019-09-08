require "application_system_test_case"

class ResearchesTest < ApplicationSystemTestCase
  setup do
    @research = researches(:one)
  end

  test "visiting the index" do
    visit researches_url
    assert_selector "h1", text: "Researches"
  end

  test "creating a Research" do
    visit researches_url
    click_on "New Research"

    fill_in "China image url", with: @research.china_image_url
    fill_in "China price", with: @research.china_price
    fill_in "China title", with: @research.china_title
    fill_in "China url", with: @research.china_url
    fill_in "Item", with: @research.item_id
    fill_in "Japan description", with: @research.japan_description
    fill_in "Japan image url", with: @research.japan_image_url
    fill_in "Japan price", with: @research.japan_price
    fill_in "Japan title", with: @research.japan_title
    fill_in "Japan url", with: @research.japan_url
    fill_in "User", with: @research.user_id
    click_on "Create Research"

    assert_text "Research was successfully created"
    click_on "Back"
  end

  test "updating a Research" do
    visit researches_url
    click_on "Edit", match: :first

    fill_in "China image url", with: @research.china_image_url
    fill_in "China price", with: @research.china_price
    fill_in "China title", with: @research.china_title
    fill_in "China url", with: @research.china_url
    fill_in "Item", with: @research.item_id
    fill_in "Japan description", with: @research.japan_description
    fill_in "Japan image url", with: @research.japan_image_url
    fill_in "Japan price", with: @research.japan_price
    fill_in "Japan title", with: @research.japan_title
    fill_in "Japan url", with: @research.japan_url
    fill_in "User", with: @research.user_id
    click_on "Update Research"

    assert_text "Research was successfully updated"
    click_on "Back"
  end

  test "destroying a Research" do
    visit researches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Research was successfully destroyed"
  end
end
