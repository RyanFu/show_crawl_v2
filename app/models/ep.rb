class Ep < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :sources
  belongs_to :shows
end
