class RecipesController < ApplicationController
	  def index
	@recipes = Recipe.all
  end

  def show
	@recipe = Recipe.find_by(id: params[:id])
  end

  def new
  end

  def create
	@recipe = Recipe.new
	@recipe.name = params[:name]
	@recipe.ingredients = params[:ingredients]
	@recipe.cook_time = params[:cook_time]
	@recipe.save
	redirect_to recipe_path(@recipe)
  end

  def edit
	@recipe = Recipe.find_by(id: params[:id])
  end

  def update
	@recipe = Recipe.find_by(id: params[:id])
	@recipe.name = params[:name]
	@recipe.ingredients = params[:ingredients]
	@recipe.cook_time = params[:cook_time]
	@recipe.save
	redirect_to recipe_path(@recipe)
  end
end
