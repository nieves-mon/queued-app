class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        pending_tasks = current_user.tasks.where("completed = ?", false).order(:due_date)

        @overdue_tasks = pending_tasks.where("due_date < ?", Date.current)
        @today_tasks = pending_tasks.where("due_date = ?", Date.current)
        @future_tasks = pending_tasks.where("due_date > ?", Date.current)

        @completed_tasks = current_user.tasks.where("completed = ?", true).order(due_date: :desc)
    end

    def show
    end

    def new
        if current_user.categories.any?
            @task = Task.new
        else
            flash[:info] = "Must have atleast one category before adding a task"
            redirect_back(fallback_location: root_path)
        end
    end

    def create
        @task = current_user.tasks.build(task_params)

        if @task.save
            flash[:success] = "Task created successfully!"
            redirect_to @task
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            if params[:commit] == "Update Task"
                flash[:success] = "Task updated successfully!"
                redirect_to @task
            else
                redirect_back(fallback_location: root_path)
            end
        else
            render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to category_url(@task.category)
    end

    private
        def task_params
            params.require(:task).permit(:title, :notes, :due_date, :category_id, :completed)
        end

        def set_task
            @task = current_user.tasks.find(params[:id])
        end
end
