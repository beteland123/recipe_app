require 'rails_helper'

RSpec.describe 'recipe_foods/new.html.erb', type: :view do
  let(:recipe) { FactoryBot.create(:recipe) }

  before do
    assign(:recipe_food, RecipeFood.new)
    assign(:recipe, recipe)
  end

  it 'renders the form' do
    render
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'displays the food select field' do
    render
    expect(rendered).to have_selector('select[name="recipe_food[food_id]"]')
  end
end
