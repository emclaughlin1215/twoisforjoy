class StaticPagesController < ApplicationController
  def index
  	@hero_path = '/heros/snow-1120800.jpg'
  	@hero_heading = "Erin McLaughlin"
  	@hero_text = "Certified Drupal and Rails Web Developer"
  	@hero_alignment = 'left'
    @posts = Post.all.limit(3).order("created_at desc")
    @projects = Project.all.limit(3).order("created_at desc")
  end
end
