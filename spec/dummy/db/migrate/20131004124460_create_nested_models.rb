class CreateNestedModels < ActiveRecord::Migration
  def up
    create_table :nested_models do |t|
      t.string  :name
      t.integer :page_id
      t.integer :image_id
      t.integer :position
      t.timestamps
    end
  end

  def down
    drop_table :nested_models
  end
end
