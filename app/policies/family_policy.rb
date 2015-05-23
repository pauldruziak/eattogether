class FamilyPolicy < ApplicationPolicy
  def show?
    user && participant?
  end

  def create?
    user && participant?
  end

  def update?
    user && participant?
  end

  def destroy?
    user && participant?
  end

  private

  def participant?
    record.event && record.event.participant?(user)
  end
end
