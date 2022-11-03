require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:user1)
    @category1 = categories(:one)
  end

  test "visiting the index" do
    visit categories_url

    assert_selector "h1", text: "All Categories"
    assert_selector ".btn", text: "Create A New Category"
    assert_selector ".card-title", text: @category1.name
  end

  test "creating a category" do
    visit categories_url

    click_on "Create A New Category"

    fill_in "Name", with: "Category Two"

    click_on "Create Category"

    assert_text "Category created successfully!"
    assert_text "Category Two"
  end

  test "updating a category" do
    visit categories_url

    click_on "Edit", match: :first

    fill_in "Name", with: "Updated"

    click_on "Update Category"

    assert_text "Category updated successfully!"
    assert_text "Updated"
  end

  test "destroying a category" do
    visit categories_url

    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Category deleted successfully!"
  end
end
