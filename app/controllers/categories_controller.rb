class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @categories = current_user.categories
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to @category
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to @category
        else
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_url
    end

    private
        def category_params
            params.require(:category).permit(:name, :user_id)
        end

        def set_category
            @category = current_user.categories.find(params[:id])
        end
end
