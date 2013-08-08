class AddPromoTitleContentToAppprojects < ActiveRecord::Migration
  def change
  	add_column :appprojects, :promo_title, :string
  	add_column :appprojects, :content, :string

  end
end
