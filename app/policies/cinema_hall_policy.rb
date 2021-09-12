# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  def update?
    access?
  end

  def create?
    access?
  end

  def show?
    access?
  end

  def index?
    access?
  end

  private

  def access?
    user.role.role_name == 'employee' || user.role.role_name == 'manager'
  end
end
