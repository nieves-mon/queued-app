require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user2 = users(:user2)
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
end
