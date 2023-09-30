#require 'rails_helper'

#RSpec.describe "recipes/show", type: :view do
#  let(:user) { create(:user) }
#  let(:recipe) { create(:recipe, user: user) }

#  before do
#    assign(:recipe, recipe)
#    assign(:recipe_foods, [])
#    assign(:user, user)
#  end

#  context "when the recipe is public" do
#    before do
#      recipe.update(public: true)
#    end

#    it "displays the recipe name" do
#      render
#      expect(rendered).to have_selector("h1", text: recipe.name)
#    end

#    it "displays the recipe details" do
#      render
#      expect(rendered).to render_template(partial: "_recipe_details")
#    end

#    it "displays the 'Make it Private' button for the recipe owner" do
#      render
#      expect(rendered).to have_selector("button", text: "Make it Private")
#    end
#  end

#  context "when the recipe is private" do
#    before do
#      recipe.update(public: false)
#    end

#    it "displays a message that the recipe is private" do
#      render
#      expect(rendered).to have_selector("p", text: "This recipe is private.")
#    end

#    it "does not display the 'Make it Private' button" do
#      render
#      expect(rendered).not_to have_selector("button", text: "Make it Private")
#    end
#  end

#  # Add more tests for other elements in the view, such as preparation time, cooking time, etc.
#end
