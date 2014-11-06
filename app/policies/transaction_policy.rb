class TransactionPolicy < ApplicationPolicy
  def new?
    user && participant?
  end

  def show?
    user && participant?
  end

  def create?
    user && participant?
  end

  def update?
    user && creator?
  end

  def destroy?
    user && creator?
  end

  private

  def participant?
    record.event && record.event.participant?(user)
  end

  def creator?
    record.creator == user
  end
end
