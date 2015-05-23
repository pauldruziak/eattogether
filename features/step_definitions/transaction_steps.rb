Given(/^що існуює транзакція де (.*?) заплатив за (.*?) (\d+)$/) do |first_name, second_name, amount|
  create_transaction payer_name: first_name, debtor_name: second_name, amount: amount
end

Given(/^я заплатив за (.*?) (\d+)$/) do |second_name, amount|
  create_transaction debtor_name: second_name, amount: amount
end


def create_transaction(payer_name: @user.name, debtor_name: , amount:)
  payer = @event.participants.joins(:user).where(users: { name: payer_name }).first
  debtor = @event.participants.joins(:user).where(users: { name: debtor_name }).first
  create :transaction, event: @event,
                       amount: amount,
                       creator: payer.user,
                       payer_id: payer.id,
                       debtors_attributes: [{ selected: "1", participant_id: debtor.id }]
end
