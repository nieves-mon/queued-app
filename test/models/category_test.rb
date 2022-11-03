require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user2 = users(:user2)
    @category2 = categories(:two)
    @category1 = categories(:one)
  end

  test "should save with all attributes" do
    category = Category.new(name: 'name', user: @user2)
    result = category.save
    assert result, "Category did not save with all attributes"
  end

  test "should not save without name" do
    category = Category.new(name: nil, user: @user2)
    result = category.save
    assert_not result, "Category saved without name"
  end

  test "should not save without user" do
    category = Category.new(name: 'name', user: nil)
    result = category.save
    assert_not result, "Category saved without user"
  end

  test "should not save without all attributes" do
    category = Category.new(name: nil, user: nil)
    result = category.save
    assert_not result, "Category saved without all attributes"
  end

  test "should not save duplicate category" do
    category = Category.new(name: @category2.name, user: @user2)
    result = category.save
    assert_not result, "Duplicate category was saved"
  end

  test "should save category that is the same name owned by a different user" do
    category = Category.new(name: @category1.name, user: @user2)
    result = category.save
    assert result, "Category with same name as one owned by a different user was not saved"
  end
end
