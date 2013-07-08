class CreateSourceV2s < ActiveRecord::Migration
  def change
    create_table :source_v2s do |t|
      t.string :link
      t.integer :ep_v2_id
      t.timestamps
    end
    add_index :source_v2s, :ep_v2_id
  end
end
