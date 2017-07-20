class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :date_loaded, :counter
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

end
