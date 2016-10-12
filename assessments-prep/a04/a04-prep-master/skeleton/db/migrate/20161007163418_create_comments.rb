class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, index: true, polymorphic:true

      t.timestamps null: false
    end
    add_foreign_key :comments, :commentables
  end
end
