require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    sign_in users(:user1)
    @category1 = categories(:one)
    @task1 = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url

    assert_selector "h1", text: "All Tasks"
  end

  test "viewing a task" do
    visit tasks_url

    click_on "View Task"

    assert_selector "h1", text: @task1.title
    assert_selector ".notes", text: @task1.notes
  end

  test "creating a task" do
    visit tasks_url

    click_on "Add A New Task"

    fill_in "Title", with: "Task Three"
    select "#{@category1.name}", from: "task[category_id]"
    fill_in "Notes", with: "Task Three Notes"
    fill_in "Due date", with: '11-10-2022'

    click_on "Add Task"

    assert_text "Task created successfully!"
    assert_selector "h1", text: "Task Three"
    assert_selector ".notes", text: "Task Three Notes"
  end

  test "updating a task" do
    visit tasks_url

    click_on "Edit Task"

    fill_in "Title", with: "My Updated Task One"
    fill_in "Notes", with: "My Updated Task One Notes"
    fill_in "Due date", with: '11-11-2022'
    check "Completed"

    click_on "Update Task"

    assert_text "Task updated successfully!"
    assert_selector "h1", text: "My Updated Task One"
    assert_selector ".notes", text: "My Updated Task One Notes"
  end

  test "deleting a task" do
    visit tasks_url

    page.accept_confirm do
      click_on "Delete Task"
    end

    assert_text "Task deleted successfully"
  end
end
