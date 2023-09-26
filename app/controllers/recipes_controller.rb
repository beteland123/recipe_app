class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes_list recipe_details]
  before_action :set_recipe, only: %i[recipe_details toggle_public]

  def public_recipes_list
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def recipe_details
    if @recipe.public || @recipe.user == current_user
      @recipe_foods = @recipe.foods
    else
      flash[:alert] = "This recipe is not public, and you don't have permission to view it."
      redirect_to public_recipes_list_path
    end
  end

  def toggle_public
    if @recipe.user == current_user
      @recipe.update(public: !@recipe.public)
      flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
    else
      flash[:alert] = "You don't have permission to modify this recipe."
    end

    redirect_to recipe_details_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
