class CreateTypeV2s < ActiveRecord::Migration
  def change
    create_table :type_v2s do |t|
      t.string :name
      t.timestamps
    end
  end
end
