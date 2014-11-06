class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :participants
  has_many :transactions

  validates :title, :creator_id, presence: true

  before_create :add_creator_to_participants

  accepts_nested_attributes_for :participants, reject_if: proc { |a| a['default_name'].blank? }

  def participant?(user)
    if new_record? || participants.loaded?
      participants.select { |p| p.user_id == user.id }.present?
    else
      participants.where(user_id: user.id).exists?
    end
  end

  def participants_without_owner
    participants.where('user_id IS NULL OR user_id != ?', creator_id)
  end

  private

  def add_creator_to_participants
    participants.build user_id: creator.id, default_name: creator.name
  end
end
