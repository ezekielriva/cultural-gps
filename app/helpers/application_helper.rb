module ApplicationHelper
  def isLogged?
    true if current_admin or current_user
  end
end
