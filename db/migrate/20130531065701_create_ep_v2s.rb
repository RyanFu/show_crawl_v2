class CreateEpV2s < ActiveRecord::Migration
  def change
    create_table :ep_v2s do |t|
      t.string :title
      t.integer :show_id

      t.timestamps
    end
    add_index :ep_v2s, :show_id
  end
end
