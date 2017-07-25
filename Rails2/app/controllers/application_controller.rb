class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :date_loaded, :counter
  before_action :set_i18n_locale_from_params
  # before_action :counter
  def date_loaded
    return Time.now
  end

  def counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
    return session[:counter]
  end

  protected
     def set_i18n_locale_from_params
     if params[:locale]
     if I18n.available_locales.map(&:to_s).include?(params[:locale])
     I18n.locale = params[:locale]
     else
     flash.now[:notice] =
     "#{params[:locale]} translation not available"
     logger.error flash.now[:notice]
     end
     end
     end

end
