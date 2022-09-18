class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def show?
    record.pincode.blank? ||
    user_is_owner? ||
    record.pincode_valid?(cookies["events_#{record.id}_pincode"])
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?
    user.present? && record.user == user
  end
end
