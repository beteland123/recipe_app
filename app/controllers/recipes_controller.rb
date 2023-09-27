class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :toggle_public, :add_food, :create_food]

  def index
    @recipes = current_user.recipes
  end

  def show
    # Display recipe details
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
  end

  def toggle_public
    @recipe.toggle!(:public)
    redirect_to @recipe, notice: 'Recipe privacy updated.'
  end

  def add_food
    @food = Food.new
  end

  def create_food
    @food = @recipe.foods.build(food_params)
    if @food.save
      redirect_to @recipe, notice: 'Food was successfully added to the recipe.'
    else
      render :add_food
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    # Define the permitted parameters for creating/updating a recipe
  end

  def food_params
    # Define the permitted parameters for creating food
  end
end
