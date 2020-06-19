class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, :ingredients, :cook_time
    end
  end
end
