class RecipeFoodsController < ApplicationController
    before_action :set_food_recipe
       def new
          @recipe_food = RecipeFood.new
      end
      
      def create
        @recipe_food = RecipeFood.new(recipe_food_params)
      
        if @recipe_food.save
            flash[:notice] = 'Recipe food created successfully'
           redirect_to recipe_path(@recipe.id)

        else
          render 'new'
        end
      end
      
      def edit
        @recipe_food = RecipeFood.find(params[:id])
      end
      
      def update
        @recipe_food = RecipeFood.find(params[:id])
      
        if @recipe_food.update(quantity: params[:quantity])
            flash[:notice] = 'Recipe food updated successfully'
            redirect_to recipe_path(@recipe_food.recipe_id)
        else
            flash[:alert] = 'Failed to update'
            render 'edit'
        end
      end
      
      def destroy
        @recipe_food = RecipeFood.find(params[:id])
        if @recipe_food.destroy
            flash[:success] = 'recipe_food deleted successfully'
          else
            flash[:error] = 'Error: recipe_food could not be deleted'
          end
      
        redirect_to recipe_path(params[:recipe_id])
      end
      
      private
      
      def set_food_recipe
        @available_foods = Food.all
        @recipe =  Recipe.find(params[:recipe_id])
      end

      def recipe_food_params
        params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
      end
end
