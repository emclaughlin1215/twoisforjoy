class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_accessor :hero_path, :title, :hero_heading, :hero_text, :hero_alignment
end
