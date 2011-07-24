class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :position
      t.string :name
      t.string :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
