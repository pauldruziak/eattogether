class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :default_name, :event_id, presence: true
end
