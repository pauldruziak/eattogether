class Transaction < ActiveRecord::Base
  attr_accessor :payer_id

  belongs_to :event
  belongs_to :creator, class_name: 'User'
  has_many :payers, dependent: :destroy
  has_many :debtors, dependent: :destroy

  validates :amount, :event_id, presence: true

  before_save :split_amount

  accepts_nested_attributes_for :debtors, reject_if: proc { |a| a['selected'] == '0' }
  accepts_nested_attributes_for :payers

  def payer_id=(value)
    @payer_id = value
    payers.build participant_id: value
  end

  def debt_for(participant)
    if debtors.loaded?
      debtors.select { |debtor| debtor.participant_id == participant.id }.first
    else
      debtors.where(participant_id: participant.id).first
    end.try(:amount) || 0.0
  end

  def debtors_name
    debtors.map { |debtor| debtor.participant.display_name }
  end

  def payers_name
    payers.map { |payer| payer.participant.display_name }
  end

  private

  def split_amount
    split_amount_for debtors
    split_amount_for payers
  end

  def split_amount_for(persons)
    return if persons.empty?
    persons.each { |person| person.amount = amount.to_f / persons.size }
    person_amount = persons.map(&:amount_in_coins).reduce(&:+)
    persons[rand(persons.size)].amount += (amount * 100 - person_amount) / 100.0
  end
end
