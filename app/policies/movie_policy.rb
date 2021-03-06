# frozen_string_literal: true

class MoviePolicy < ApplicationPolicy
  def update?
    access?
  end

  def create?
    access?
  end

  private

  def access?
    user.role.role_name == 'employee' || user.role.role_name == 'manager'
  end
end
