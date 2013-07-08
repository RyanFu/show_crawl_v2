class CreateEps < ActiveRecord::Migration
  def change
    create_table :eps do |t|
      t.string :title
      t.integer :show_id

      t.timestamps
    end
    add_index :eps, :show_id
  end
end
