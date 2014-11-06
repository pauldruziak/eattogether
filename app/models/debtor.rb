class Debtor < ActiveRecord::Base
  attr_accessor :selected
  belongs_to :participant

  def amount=(value)
    super((value * 100).to_i)
  end

  def amount
    super.to_i / 100.0
  end

  def amount_in_coins
    self['amount']
  end
end
