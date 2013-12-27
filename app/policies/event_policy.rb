class EventPolicy < ApplicationPolicy
  def show?
    user && record.participants.where(user_id: user.id).exists?
  end

  def create?
    user
  end

  def update?
    user && record.creator == user
  end

  def destroy?
    user && record.creator == user
  end
end