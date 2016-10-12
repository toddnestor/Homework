class AddLinkToCommentAgain < ActiveRecord::Migration
  def change
    add_column :comments, :link_id, :integer, index: true
  end
end
