class Type < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :shows
end
