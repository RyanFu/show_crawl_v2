class EpV2 < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :source_v2s
  belongs_to :show_v2
end
