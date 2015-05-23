class Family < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :event
  has_many :family_members, class_name: 'Participant', dependent: :nullify

  validates :name, :creator_id, :event_id, :family_members, presence: true

  def family_members_attributes=(attributes)
    family_member_ids = attributes.select { |_, a| a['selected'] == '1' }.map { |_, a| a['id'] }
    self.family_members << Participant.where(id: family_member_ids)
  end
end
