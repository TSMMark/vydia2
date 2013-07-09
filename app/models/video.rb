class Video < ActiveRecord::Base
  attr_accessible :link, :name

  belongs_to :user, inverse_of: :videos
end
