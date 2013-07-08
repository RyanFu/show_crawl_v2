class CreateShowV2s < ActiveRecord::Migration
  def change
    create_table :show_v2s do |t|
      t.string :name
      t.text :introduction
      t.integer :type_id
      t.string :poster_url
      t.string :hosts
      t.string :link
      t.boolean :is_shown, :default => false
      t.integer :views, :default => 0
      t.timestamps
    end
  end
end
