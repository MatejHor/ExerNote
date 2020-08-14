class UnauthorizedController < ActionController::Metal
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers

  def self.call(env)
    @respond ||= action(:redirect_to_register)
    @respond.call(env)
  end

  def redirect_to_register
    redirect_to home_path
  end
end
