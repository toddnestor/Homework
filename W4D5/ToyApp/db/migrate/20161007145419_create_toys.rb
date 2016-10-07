class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name
      t.references :toyable, index: true, polymorphic: true

      t.timestamps null: false
    end
    add_index :toys, :name, unique: true
  end
end
