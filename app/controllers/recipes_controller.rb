class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy toggle_public add_food create_food]

  def index
    @recipes = current_user.recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
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
    @recipe.toggle!(:public)
    if @recipe.public
      redirect_to public_recipes_path, notice: 'Recipe is now public.'
    else
      redirect_to @recipe, notice: 'Recipe is now private.'
    end
  end

  def update_times
    @recipe = Recipe.find(params[:id])

    if current_user == @recipe.user
      if @recipe.update(recipe_params) # Use recipe_params here
        redirect_to @recipe, notice: 'Preparation and cooking times updated.'
      else
        render :show
      end
    else
      redirect_to @recipe, alert: 'You are not authorized to update this recipe.'
    end
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
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :unit)
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
    render 'public_index'
  end
end
