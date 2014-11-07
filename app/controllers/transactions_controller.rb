class TransactionsController < ApplicationController
  before_filter :set_event, except: [:show, :destroy]

  def new
    @transaction = @event.transactions.build
    @transaction.payer_id = @event.participants.where(user_id: current_user.id).first.try(:id)
    @event.participants.each { |p| @transaction.debtors.build participant: p, selected: true }
    authorize @transaction
  end

  def create
    @transaction = @event.transactions.build transaction_params.merge(creator: current_user)
    authorize @transaction
    if @transaction.save
      flash[:info] = 'Successfuly created transaction'
      redirect_to @event
    else
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    authorize @transaction
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @event = @transaction.event
    authorize @transaction, :destroy?
    @transaction.destroy
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def transaction_params
    params.require(:transaction).permit(:description,
                                        :amount,
                                        :payer_id,
                                        debtors_attributes: [:participant_id, :selected])
  end
end
