class AddDefaultValuesToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    change_column_default :recipe_foods, :quantity, 0
  end
end
