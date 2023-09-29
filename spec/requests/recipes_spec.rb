# spec/controllers/recipes_controller_spec.rb

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    sign_in user
  end

  # ... (previous tests for other actions)

  describe "GET #show" do
    it "assigns the requested recipe to @recipe" do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it "assigns @recipe_foods" do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe_foods)).to eq(recipe.recipe_foods)
    end

    it "assigns @user" do
      get :show, params: { id: recipe.id }
      expect(assigns(:user)).to eq(user)
    end

    it "renders the show template" do
      get :show, params: { id: recipe.id }
      expect(response).to render_template("show")
    end

    it "redirects to the login page if the user is not authenticated" do
      sign_out user
      get :show, params: { id: recipe.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
