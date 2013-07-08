class AddPrelinkToEpV2 < ActiveRecord::Migration
  def change
  	add_column :ep_v2s, :prelink, :string
  end
end
