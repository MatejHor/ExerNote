class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  around_action :switch_locale

  def switch_locale(&action)
    if params[:locale]
      session[:locale] = params[:locale]
    end
    locale = session[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
