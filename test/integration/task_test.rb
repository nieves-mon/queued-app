require "test_helper"

class TaskTest < ActionDispatch::IntegrationTest
  setup do
    @category1 = categories(:one)
    @category2 = categories(:two)
    @task1 = tasks(:one)
    @task2 = tasks(:two)
    sign_in users(:user1)
  end

  test "should show index" do
    get tasks_path

    assert_select "h1", "All Tasks"
    assert_select ".btn", "Add A New Task"
    assert_select ".task-title", @task1.title
    assert_select ".task-due-date", @task1.due_date.strftime("%^a %b %d, %Y")
    assert :success
  end

  test "should not show index if user is signed out" do
    sign_out users(:user1)

    get tasks_path
    assert_response :redirect
  end

  test "should show task" do
    get task_path(@task1)

    assert_select "h1", @task1.title
    assert_select ".due-date", @task1.due_date.strftime("%^a %b %d, %Y")
    assert_select ".notes", @task1.notes
    assert_response :success
  end

  test "should show new page" do
    get new_task_path

    assert_select "h1", "New Task"
    assert_select "input"
    assert_response :success
  end

  test "should create new task" do
    assert_difference "Task.count", 1 do
      post tasks_path, params: {task: {title: 'My Task Three', notes: 'My Task Three Notes', due_date: '2022-11-10', completed: false, category_id: @category1.id}}
    end

    assert_equal(Task.last.title, 'My Task Three')
    assert_response :redirect
  end

  test "should show edit page" do
    get edit_task_path(@task1)

    assert_select "h1", "Edit Task"
    assert_select "input"
    assert_response :success
  end

  test "should update task" do
    patch task_path(@task1), params: {task: {completed: true}}

    assert_equal(Task.last.completed, true)
    assert_response :redirect
  end

  test "should delete task and redirect" do
    assert_difference "Task.count", -1 do
      delete task_path(@task1)
    end

    assert_select ".task-title", false, @task1.title
    assert_response :redirect
  end

  test "should not delete task owned by different user" do
    assert_difference "Task.count", 0 do
      assert_raise Exception do
        delete task_path(@task2)
      end
    end
  end
end
