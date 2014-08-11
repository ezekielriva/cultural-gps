module ApplicationHelper
  def isLogged?
    current_admin or current_user
  end
end
