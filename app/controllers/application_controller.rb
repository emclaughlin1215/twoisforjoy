class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_accessor :hero_path, :title
end
