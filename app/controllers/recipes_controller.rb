class RecipesController < ApplicationController
	before_action :authenticate_user!, except: [:public_index, :show]
    before_action :set_recipe, only: [:show, :edit, :update, :destroy, :toggle_public]

  def index
    @recipes = current_user.recipes.all
  end

  def public_index
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def toggle_public
    if @recipe.user == current_user
      @recipe.toggle!(:public)
    end
    redirect_to @recipe
  end

  def new; end

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
