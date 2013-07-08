class Show < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :type
  has_many :eps
end
