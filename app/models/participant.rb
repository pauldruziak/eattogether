class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :default_name, presence: true

  def display_name
    default_name
  end

  def paid
    @paid ||= Payer.where(participant_id: id).sum(:amount)
  end

  def debt
    @debt ||= Debtor.where(participant_id: id).sum(:amount)
  end

  def amount
    (paid - debt) / 100.0
  end
end
