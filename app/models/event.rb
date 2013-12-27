class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :participants

  validates :title, :creator_id, presence: true

  before_create :add_creator_to_participants

  private
    def add_creator_to_participants
      participants.build user_id: creator.id, default_name: creator.name
    end
end
