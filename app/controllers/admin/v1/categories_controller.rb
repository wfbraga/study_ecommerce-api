module Admin::V1
  class CategoriesController < ApiController
    before_action :load_categories, only: [:update, :destoy]
    before_action :category_params, only: :show
    def index
      @categories = load_categories
    end

    def show
      @category = Category.find(params[:id])
    end

    def create
      @category = Category.new
      @category.attributes = category_params
      save_category!
    end

    def update
      @category = Category.find(params[:id])
      @category.attributes = category_params
      save_category!
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy!
    rescue
      render_error(fields: @category.errors.messages)
    end

    private

    def load_categories
      permited = params.permit({search: :name}, {order:{}}, :page, :length)
      Admin::ModelLoadingService.new(Category.all, permited).call
    end

    def category_params
      return {} unless params.has_key?(:category)

      params.require(:category).permit(:id, :name)
    end

    def save_category!
      @category.save!
      render :show
    rescue
      render_error(fields: @category.errors.messages)
    end
  end
end
