class TransactionMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_transaction(transaction_id)
    @transaction = Transaction.find(transaction_id)
    @event = @transaction.event
    recipients = @event.participants.preload(:user).map { |p| p.email }.compact

    mail bcc: recipients, subject: "Їмо Разом: #{@event.title}"
  end
end
