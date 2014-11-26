class AddUrlAndNotesToItems < ActiveRecord::Migration
  def change
    add_column :items, :url, :string
    add_column :items, :notes, :string
  end
end
