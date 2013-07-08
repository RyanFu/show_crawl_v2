class SourceV2 < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :id, :link, :ep_v2_id
  belongs_to :ep_v2
end
