class AddPrelinkToEp < ActiveRecord::Migration
  def change
  	add_column :eps, :prelink, :string
  end
end
