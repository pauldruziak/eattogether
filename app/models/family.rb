class Family < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :event

  validates :name, :creator_id, :event_id, presence: true
end
