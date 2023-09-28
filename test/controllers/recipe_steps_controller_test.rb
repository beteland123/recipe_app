require "test_helper"

class RecipeStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recipe_steps_new_url
    assert_response :success
  end

  test "should get create" do
    get recipe_steps_create_url
    assert_response :success
  end
end
