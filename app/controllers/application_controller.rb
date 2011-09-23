class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :date_time_format

  def date_time_format
    Time::DATE_FORMATS[:only_year] = "%Y"
  end

end
