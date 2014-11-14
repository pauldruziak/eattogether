class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :payers
  has_many :debtors

  validates :default_name, presence: true

  def amount
    (paid - debt) / 100.0
  end

  def debt
    @debt ||= Debtor.where(participant_id: id).sum(:amount)
  end

  def display_name
    default_name
  end

  def email
    user.try(:email)
  end

  def email=(email)
    if user = User.find_by_email(email)
      self.user = user
    else
      user = User.invite! email: email, name: default_name
      self.user = user
    end
  end

  def paid
    @paid ||= Payer.where(participant_id: id).sum(:amount)
  end

end
