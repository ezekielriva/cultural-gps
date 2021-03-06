class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def decorators
    @memoized ||= CollectDecorator.new
  end

  helper_method :decorators

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

end
