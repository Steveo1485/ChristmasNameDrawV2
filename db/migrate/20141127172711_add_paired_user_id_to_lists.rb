class AddPairedUserIdToLists < ActiveRecord::Migration
  def change
    add_column :lists, :paired_user_id, :integer
  end
end
