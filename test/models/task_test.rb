require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @category1 = categories(:one)
    @user1 = users(:user1)
  end

  test "should save task with complete attributes" do
    task = Task.new(title: 'title', notes: 'notes', due_date: '2022-11-10', completed: false, category: @category1, user: @user1)
    result = task.save
    assert result, "Task did not save with complete attributes"
  end

  test "should not save task without title" do
    task = Task.new(title: nil, notes: 'notes', due_date: '2022-11-10', completed: false, category: @category1, user: @user1)
    result = task.save
    assert_not result, "Task saved without title"
  end

  test "should not save task without due_date" do
    task = Task.new(title: 'title', notes: 'notes', due_date: nil, completed: false, category: @category1, user: @user1)
    result = task.save
    assert_not result, "Task saved without due_date"
  end

  test "should not save without user reference" do
    task = Task.new(title: 'title', notes: 'notes', due_date: '2022-11-10', completed: false, category: @category1, user: nil)
    result = task.save
    assert_not result, "Task saved without user reference"
  end

  test "should not save without category reference" do
    task = Task.new(title: 'title', notes: 'notes', due_date: '2022-11-10', completed: false, category: nil, user: @user1)
    result = task.save
    assert_not result, "Task saved without category reference"
  end

  test "should not save without all attributes" do
    task = Task.new(title: nil, notes: nil, due_date: nil, completed: nil, category: nil, user: nil)
    result = task.save
    assert_not result, "Task saved without all attributes"
  end
end
