require "test_helper"

class CategoryTest < ActionDispatch::IntegrationTest
  setup do
    @category1 = categories(:one)
    @category2 = categories(:two)
    sign_in users(:user1)
  end

  test "should get index page" do
    get categories_path

    assert_select "h1", "All Categories"
    assert_select ".card-title", @category1.name
    assert_response :success, "Index page did not show while user is signed in"
  end

  test "should not get index page" do
    sign_out users(:user1)

    get categories_path
    assert_response :redirect, "Index page showed while user is signed out"
  end

  test "should get new page" do
    get new_category_path

    assert_select "h1", "New Category"
    assert_select "input"
    assert_select "label", "Name"
    assert_response :success, "New page did not show"
  end

  test "should show category" do
    get category_path(@category1)

    assert_select "h1", @category1.name
    assert_response :success
  end

  test "should not show category owned by different user" do
    assert_raise Exception do
      get category_path(@category2)
    end
  end

  test "should get create new category and redirect" do
    assert_difference "Category.count", 1 do
      post categories_path, params: {category: {name: "CategoryThree"}}
    end

    assert_equal(Category.last.name, "CategoryThree")
    assert_response :redirect, "Did not redirect after creating category"
  end

  test "should not create duplicate category" do
    post categories_path params: {category: {name: "CategoryOne"}}
    assert_select '.error', 'Name has already been taken'
    assert_equal(Category.count, 2)
  end

  test "should not create category without name" do
    assert_difference "Category.count", 0 do
      post categories_path params: {category: {name: nil}}
    end

    assert_select '.error', "Name can't be blank"
  end

  test "should show edit page" do
    get edit_category_path(@category1)

    assert_select "h1", "Edit Category"
    assert_select "input"
    assert_select "label", "Name"
    assert_response :success, "Edit category page did not show"
  end

  test "should update category and redirect" do
    assert_difference "Category.count", 0 do
      patch category_path(@category1), params: {category: {name: "New Category One"}}
    end

    assert_equal(Category.find(@category1.id).name, "New Category One")
    assert_response :redirect
  end

  test "should delete category and redirect" do
    assert_difference "Category.count", -1 do
      delete category_path(@category1)
    end

    assert_select ".card-title", false, @category1.name
    assert_response :redirect, "Did not redirect after deleting category"
  end

  test "should not delete category not owned by user" do
    assert_difference "Category.count", 0 do
      assert_raise Exception do
        delete category_path(@category2)
      end
    end
  end
end
