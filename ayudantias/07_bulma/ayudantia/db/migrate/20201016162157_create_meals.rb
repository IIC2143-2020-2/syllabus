class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :thumb
      t.integer :mealId

      t.timestamps
    end
  end
end
