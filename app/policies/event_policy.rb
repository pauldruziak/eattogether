class EventPolicy < ApplicationPolicy
  def show?
    user && record.owner == user
  end

  def create?
    user
  end

  def update?
    user && record.owner == user
  end

  def destroy?
    user && record.owner == user
  end
end