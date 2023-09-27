class FoodsController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = current_user.foods
  end

  def new
    @current_user = current_user
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      flash[:success] = 'Food saved successfully'
      redirect_to foods_path
    else
      flash.now[:error] = 'Error: Food could not be saved'
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_url
  end

  def shopping_list
    @recipes = Recipe.where(user: current_user)
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
    @general_food_list = Food.where(user: current_user)
    

    @missing_food_items = []
    @recipes.each do |recipe|
        @recipe_foods.each do |recipe_food|
          general_food = @general_food_list.find_by(id: recipe_food.food_id)
          if general_food.nil? || general_food.quantity < recipe_food.quantity
            @missing_food_items << {
              food_name: recipe_food.food.name,
              quantity_needed: recipe_food.quantity,
              price: recipe_food.food.price
            }
          end
        end
      end

  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
