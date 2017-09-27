class StaticPagesController < ApplicationController
  def index
  	@hero_path = 'snow-1120800.jpg'
    @posts = Post.all.limit(3).order("created_at desc")
    @projects = Project.all.limit(3).order("created_at desc")
  end
end
