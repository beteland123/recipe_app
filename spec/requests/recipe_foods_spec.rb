require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }
  let(:food) { FactoryBot.create(:food) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe food' do
      expect {
        post :create, params: { recipe_id: recipe.id, recipe_food: { food_id: food.id, quantity: 2 } }
      }.to change(RecipeFood, :count).by(1)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to be_present
    end

    it 'renders the new template if save fails' do
      allow_any_instance_of(RecipeFood).to receive(:save).and_return(false)

      post :create, params: { recipe_id: recipe.id, recipe_food: { food_id: food.id, quantity: 2 } }

      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    let(:recipe_food) { FactoryBot.create(:recipe_food, recipe: recipe, food: food) }

    it 'renders the edit template' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to render_template(:edit)
    end

    it 'redirects to the recipe if the recipe food is not found' do
      get :edit, params: { recipe_id: recipe.id, id: 'nonexistent' }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:alert]).to be_present
    end
  end

  describe 'PATCH #update' do
    let(:recipe_food) { FactoryBot.create(:recipe_food, recipe: recipe, food: food, quantity: 2) }

    it 'updates the recipe food' do
      patch :update, params: { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { quantity: 3 } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to be_present
      expect(recipe_food.reload.quantity).to eq(3)
    end

    it 'redirects to the recipe if the update fails' do
      allow_any_instance_of(RecipeFood).to receive(:update).and_return(false)

      patch :update, params: { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { quantity: 3 } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:alert]).to be_present
    end
  end

  describe 'DELETE #destroy' do
    let(:recipe_food) { FactoryBot.create(:recipe_food, recipe: recipe, food: food) }

    it 'destroys the recipe food' do
      delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:success]).to be_present
      expect(RecipeFood.find_by(id: recipe_food.id)).to be_nil
    end

    it 'redirects to the recipe if the destroy fails' do
      allow_any_instance_of(RecipeFood).to receive(:destroy).and_return(false)

      delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:error]).to be_present
    end
  end
end
