class RecipeStepsController < ApplicationController
  load_and_authorize_resource
  before_action :set_recipe

  def new
    @recipe_step = RecipeStep.new
  end

  def create
    @recipe_step = RecipeStep.new(recipe_step_params)
    @recipe_step.recipe = @recipe

    if @recipe_step.save
      flash[:notice] = 'Recipe step added successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_step_params
    params.require(:recipe_step).permit(:description)
  end
end
