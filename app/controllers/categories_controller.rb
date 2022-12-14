class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @categories = current_user.categories
    end

    def show
        tasks = @category.tasks.where("completed = ?", false).order(:due_date)

        @overdue_tasks = tasks.where("due_date < ?", Date.current)
        @today_tasks = tasks.where("due_date = ?", Date.current)
        @future_tasks = tasks.where("due_date > ?", Date.current)

        @completed_tasks = @category.tasks.where("completed = ?", true).order(due_date: :desc)
    end

    def new
        @category = Category.new
    end

    def create
        @category = current_user.categories.build(category_params)

        if @category.save
            flash[:success] = "Category created successfully!"
            redirect_to @category
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            flash[:success] = "Category updated successfully!"
            redirect_to @category
        else
            render :edit
        end
    end

    def destroy
        flash[:info] = "Category deleted successfully!"
        @category.destroy
        redirect_to categories_url
    end

    private
        def category_params
            params.require(:category).permit(:name)
        end

        def set_category
            @category = current_user.categories.find(params[:id])
        end
end
