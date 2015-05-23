class Participant < ActiveRecord::Base
  attr_accessor :selected
  belongs_to :user
  belongs_to :event
  belongs_to :family
  has_many :payers
  has_many :debtors

  validates :default_name, presence: true

  def self.without_family
    where(family_id: nil)
  end

  def amount
    (paid - debt) / 100.0
  end

  def debt
    @debt ||= Debtor.where(participant_id: id).sum(:amount)
  end

  def display_name
    default_name
  end

  def family_name
    family.try(:name) || display_name
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
