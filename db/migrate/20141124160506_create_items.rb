class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.belongs_to :list
      t.timestamps
    end
  end
end
