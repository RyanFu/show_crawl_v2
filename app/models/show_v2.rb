class ShowV2 < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :type_v2
  has_many :ep_v2s
end
