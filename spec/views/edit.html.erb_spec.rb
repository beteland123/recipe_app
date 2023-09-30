require 'rails_helper'

RSpec.describe 'recipe_foods/edit.html.erb', type: :view do
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, recipe: recipe) }

  before do
    assign(:recipe_food, recipe_food)
    assign(:recipe, recipe)
  end

  it 'renders the form' do
    render
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'displays the quantity field' do
    render
    expect(rendered).to have_selector('input[name="recipe_food[quantity]"]')
  end
end
