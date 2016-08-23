class WelcomeController < ApplicationController
  layout 'landing'

  def index
  end

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:crycen_locale] = l
    redirect_to request.referer || root_url
  end
  
end
