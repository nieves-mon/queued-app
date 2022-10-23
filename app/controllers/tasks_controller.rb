class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, :set_task_category, only: [:show]

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)

        if @task.save
            redirect_to @task
        else
            render :new
        end
    end

    private
        def task_params
            params.require(:task).permit(:title, :notes, :due_date, :user_id, :category_id)
        end

        def set_task
            @task = current_user.tasks.find(params[:id])
        end

        def set_task_category
            @task_category = current_user.categories.find(@task.category_id)
        end
end
