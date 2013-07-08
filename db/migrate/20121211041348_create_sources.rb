class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :link
      t.integer :ep_id
      t.timestamps
    end
    add_index :sources, :ep_id
  end
end
