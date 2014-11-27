class CreateAssociatedUsers < ActiveRecord::Migration
  def change
    create_table :associated_users do |t|
      t.integer :owner_user_id
      t.integer :user_id
      t.timestamps
    end
  end
end
