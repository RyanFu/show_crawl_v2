class Source < ActiveRecord::Base
  attr_accessible :id, :link, :ep_id
  belongs_to :ep
end
