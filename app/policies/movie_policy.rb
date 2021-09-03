class MoviePolicy < ApplicationPolicy
  def update? 
    user.role.role_name = 'employee' || user.role.role_name = 'manager'
  end

  def create? 
    user.role.role_name = 'employee' || user.role.role_name = 'manager'
  end

end
