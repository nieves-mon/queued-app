require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should not save task without title" do
    task = Task.new(title: nil, notes: 'notes', due_date: '2022-11-10', completed: false)
    result = task.save
    assert_not result, "Task saved without title"
  end

  test "should not save task without due_date" do
    task = Task.new(title: 'title', notes: 'notes', due_date: nil, completed: false)
    result = task.save
    assert_not result, "Task saved without due_date"
  end
end
