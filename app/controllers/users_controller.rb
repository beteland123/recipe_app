class UsersController < ApplicationController
#  before_action :authenticate_user!

  def recipes_list
    @user = current_user
    @recipes = @user.recipes
  end

  def delete_recipe
    @recipe = Recipe.find(params[:id])

    if @recipe.user == current_user
      @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully.'
    else
      flash[:alert] = "You don't have permission to delete this recipe."
    end

    redirect_to recipes_list_path
  end
end
