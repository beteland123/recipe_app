require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:food) { FactoryBot.create(:food, user: user) }

  before do
    sign_in user
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new recipe food" do
      expect {
        post :create, params: { recipe_food: FactoryBot.attributes_for(:recipe_food, recipe_id: recipe.id, food_id: food.id) }
      }.to change(RecipeFood, :count).by(1)
    end
  end

  describe "PATCH #update" do
    it "updates the recipe food quantity" do
      recipe_food = FactoryBot.create(:recipe_food, recipe: recipe, food: food)
      new_quantity = 10
      patch :update, params: { id: recipe_food.id, recipe_food: { quantity: new_quantity } }
      recipe_food.reload
      expect(recipe_food.quantity).to eq(new_quantity)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the recipe food" do
      recipe_food = FactoryBot.create(:recipe_food, recipe: recipe, food: food)
      expect {
        delete :destroy, params: { id: recipe_food.id }
      }.to change(RecipeFood, :count).by(-1)
    end
  end
end
