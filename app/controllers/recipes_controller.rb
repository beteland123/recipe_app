class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy toggle_public add_food create_food]

  def index
    @recipes = current_user.recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
    render 'public_index'
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    @user = current_user
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_url, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if current_user == @recipe.user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
    else
      redirect_to recipes_url, alert: 'You are not authorized to delete this recipe.'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def update_times
    @recipe = Recipe.find(params[:id])

    if current_user == @recipe.user
      if @recipe.update(recipe_params)
        redirect_to @recipe, notice: 'Preparation and cooking times updated.'
      else
        render :show
      end
    else
      redirect_to @recipe, alert: 'You are not authorized to update this recipe.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :unit)
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    # Calculate your shopping list data here (e.g., sum of quantities, etc.)
  end

  def add_ingredient
	@recipe = Recipe.find(params[:id])
	@food = Food.new
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
    render 'public_index'
  end
end
