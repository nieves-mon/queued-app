class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, except: [:index, :new, :create]

    def index
        @overdue_tasks = current_user.tasks.where("due_date < ?", DateTime.current)
        @today_tasks = current_user.tasks.where("due_date = ?", DateTime.current.to_date)
        @tomorrow_tasks = current_user.tasks.where("due_date = ?", DateTime.tomorrow)
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.build(task_params)

        if @task.save
            redirect_to @task
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to @task
        else
            render :edit
        end
    end

    def destroy
        redirect_to category_url(@task.category_id)
        @task.destroy
    end

    private
        def task_params
            params.require(:task).permit(:title, :notes, :due_date, :user_id, :category_id)
        end

        def set_task
            @task = current_user.tasks.find(params[:id])
        end
end
