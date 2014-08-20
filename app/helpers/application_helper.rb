module ApplicationHelper
  def isLogged?
    current_admin or current_user
  end

  def is_active?(page_name)
    "active" if params[:controller] == page_name
  end
end
