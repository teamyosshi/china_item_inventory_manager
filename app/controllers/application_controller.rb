class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  include StocksHelper
  include ResearchesHelper
  NUM=0 #カウンター初期値
end
