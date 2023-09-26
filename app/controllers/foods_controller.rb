class FoodsController < ApplicationController
    load_and_authorize_resource
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
      redirect_to foods_url
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

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
